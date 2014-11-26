// Vehicle Service Point by Axe Cop
 
private ["_folder","_servicePointClasses","_maxDistance","_actionTitleFormat","_actionCostsFormat","_costsFree","_message","_messageShown","_refuel_enable","_refuel_costs","_refuel_updateInterval","_refuel_amount","_repair_enable","_repair_costs","_repair_repairTime","_rearm_enable","_rearm_costs","_rearm_magazineCount","_lastVehicle","_lastRole","_fnc_removeActions","_fnc_getCosts","_fnc_actionTitle","_fnc_isArmed","_fnc_getWeapons"];
 
_coinsRepairAir 	= 4000;
_coinsRepairVehicles 	= 1000;
_coinsRefuelVehicles 	= 100;
_coinsRefuelAir 	= 500;
  
// general settings
_folder 		= "custom\service_point\";
_servicePointClasses 	= dayz_fuelpumparray;
_maxDistance 		= 10;
_actionTitleFormat 	= "%1 (%2)";
_actionCostsFormat 	= "%2 %1";
_costsFree 		= "free";
_message 		= "Vehicle Service Point nearby";
 
// refuel settings
_refuel_enable 		= true; // enable or disable the refuel option
_refuel_costs 		= [
				["AllVehicles",[CurrencyName,_coinsRefuelVehicles]],
				["Air",[CurrencyName,_coinsRefuelAir]]
			];
_refuel_updateInterval 	= 1;
_refuel_amount 		= 0.05;
 
// repair settings
_repair_enable 		= true;
_repair_costs 		= [
				["Air",[CurrencyName,_coinsRepairAir]],
				["AllVehicles",[CurrencyName,_coinsRepairVehicles]]
			];
 
_repair_repairTime 	= 2;

// ----------------- CONFIG END -----------------
 
_lastVehicle 		= objNull;
_lastRole 		= [];
 
SP_refuel_action 	= -1;
SP_repair_action 	= -1;
SP_rearm_actions 	= [];
 
_messageShown 		= false;
 
_fnc_removeActions = {
	if (isNull _lastVehicle) exitWith {};
	_lastVehicle removeAction SP_refuel_action;
	SP_refuel_action = -1;
	_lastVehicle removeAction SP_repair_action;
	SP_repair_action = -1;
	{
		_lastVehicle removeAction _x;
	} forEach SP_rearm_actions;
	SP_rearm_actions = [];
	_lastVehicle = objNull;
	_lastRole = [];
};
 
_fnc_getCosts = {
	private ["_vehicle","_costs","_cost"];
	_vehicle = _this select 0;
	_costs = _this select 1;
	_cost = [];
	{
		private "_typeName";
		_typeName = _x select 0;
		if (_vehicle isKindOf _typeName) exitWith {
			_cost = _x select 1;
		};
	} forEach _costs;
	_cost
};
 
_fnc_actionTitle = {
	private ["_actionName","_costs","_costsText","_actionTitle"];
	_actionName = _this select 0;
	_costs = _this select 1;
	_costsText = _costsFree;
	if (count _costs == 2) then {
		private ["_itemName","_itemCount","_displayName"];
		_itemName = _costs select 0;
		_itemCount = _costs select 1;
		_displayName = _itemName;
		_costsText = format [_actionCostsFormat, _displayName, _itemCount];
	};
	_actionTitle = format [_actionTitleFormat, _actionName, _costsText];
	_actionTitle
};

while {true} do {
	private ["_vehicle","_inVehicle"];
	_vehicle = vehicle player;
	_inVehicle = _vehicle != player;
	if (local _vehicle && _inVehicle) then {
		private ["_pos","_servicePoints","_inRange"];
		_pos = getPosATL _vehicle;
		_servicePoints = (nearestObjects [_pos, _servicePointClasses, _maxDistance]) - [_vehicle];
		_inRange = count _servicePoints > 0;
		if (_inRange) then {
			private ["_servicePoint","_role","_actionCondition","_costs","_actionTitle"];
			_servicePoint = _servicePoints select 0;
			if (assignedDriver _vehicle == player) then {
				_role = ["Driver", [-1]];
			} else {
				_role = assignedVehicleRole player;
			};
			if (((str _role) != (str _lastRole)) || (_vehicle != _lastVehicle)) then {
				call _fnc_removeActions;
			};
			_lastVehicle = _vehicle;
			_lastRole = _role;
			_actionCondition = "vehicle _this == _target && local _target";
			if (SP_refuel_action < 0 && _refuel_enable) then {
				_costs = [_vehicle, _refuel_costs] call _fnc_getCosts;
				_actionTitle = ["Refuel", _costs] call _fnc_actionTitle;
				SP_refuel_action = _vehicle addAction [_actionTitle, _folder + "service_point_refuel.sqf", [_servicePoint, _costs, _refuel_updateInterval, _refuel_amount], -1, false, true, "", _actionCondition];
			};
			if (SP_repair_action < 0 && _repair_enable) then {
				_costs = [_vehicle, _repair_costs] call _fnc_getCosts;
				_actionTitle = ["Repair", _costs] call _fnc_actionTitle;
				SP_repair_action = _vehicle addAction [_actionTitle, _folder + "service_point_repair.sqf", [_servicePoint, _costs, _repair_repairTime], -1, false, true, "", _actionCondition];
			};
			if (!_messageShown && _message != "") then {
				_messageShown = true;
				_vehicle vehicleChat _message;
			};
		} else {
			call _fnc_removeActions;
			_messageShown = false;
		};
	} else {
		call _fnc_removeActions;
		_messageShown = false;
	};
	sleep 2;
};