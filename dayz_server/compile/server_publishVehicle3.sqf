private["_activatingPlayer","_isOK","_object","_worldspace","_location","_dir","_class","_uid","_key","_keySelected","_characterID","_newObject","_continue","_result","_outcome","_countr","_objectID","_objectUID","_weapons","_magazines","_backpacks","_objWpnTypes","_objWpnQty"];

_object				= _this select 0;
_worldspace			= _this select 1;
_class				= _this select 2;
_keySelected		= _this select 4;
_activatingPlayer 	= _this select 5;
_characterID		= _keySelected;

_isOK = isClass(configFile >> "CfgVehicles" >> _class);

if(!_isOK || isNull _object) exitWith { diag_log ("HIVE-pv3: Vehicle does not exist: "+ str(_class)); };

_dir		= _worldspace select 0;
_location	= _worldspace select 1;
_uid		= _worldspace call dayz_objectUID3;

_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,0 ,_characterID,_worldspace,[],[],1,_uid];
_key call server_hiveWrite;

_continue = false;

while {!_continue} do {
	_result		= nil;
	_key 		= format["CHILD:388:%1:",_uid];
	_result 	= _key call server_hiveReadWrite;
	_outcome 	= _result select 0;

	if(_outcome == "PASS") then {
		_continue = true;
	} else {
		sleep 1;
	};
};

_objectID	= _object getVariable["ObjectID","0"];
_objectUID	= _object getVariable["ObjectUID","0"];
_weapons	= getWeaponCargo _object;
_magazines	= getMagazineCargo _object;
_backpacks	= getBackpackCargo _object;

clearWeaponCargoGlobal _object;
clearMagazineCargoGlobal _object;
clearBackpackCargoGlobal _object;

deleteVehicle _object;
[_objectID,_objectUID,_activatingPlayer] call server_deleteObj;

_newObject = createVehicle[_class,[0,0,0],[],0,"CAN_COLLIDE"];
_newObject setDir _dir;
_newObject setPosATL _location;

_objWpnTypes	= _weapons select 0;
_objWpnQty		= _weapons select 1;
_countr			= 0;

{
	_newObject addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
	_countr = _countr + 1;
} count _objWpnTypes;

_objWpnTypes	= _magazines select 0;
_objWpnQty		= _magazines select 1;
_countr			= 0;

{
	_newObject addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
	_countr = _countr + 1;
} count _objWpnTypes;

_objWpnTypes	= _backpacks select 0;
_objWpnQty		= _backpacks select 1;
_countr			= 0;

{
	_newObject addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
	_countr = _countr + 1;
} count _objWpnTypes;

_newObject setVariable["ObjectID",(_result select 1),true];
_newObject setVariable["lastUpdate",time];
_newObject setVariable["CharacterID",_characterID,true];

PVDZE_serverObjectMonitor set[count PVDZE_serverObjectMonitor,_newObject];

_newObject call fnc_veh_ResetEH;

PVDZE_veh_Init = _newObject;
publicVariable "PVDZE_veh_Init";
processInitCommands;

diag_log ("PUBLISH: " + str(_activatingPlayer) + " Upgraded " + (_class) + " with ID " + str(_uid));