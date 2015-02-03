private["_object","_worldspace","_class","_uid","_dam","_hitpoints","_selection","_dam_array","_damage","_fuel","_key","_spawn_damage","_characterID","_continue","_result","_outcome"];

_object			= _this select 0;
_worldspace		= _this select 1;
_class			= _this select 2;
_spawn_damage	= _this select 3;
_characterID	= _this select 4;

_fuel			= 1;
_damage			= 0;
_dam_array		= [];

_uid			= _worldspace call dayz_objectUID2;

if(_spawn_damage) then { 
	_fuel = 0;
	if(getNumber(configFile >> "CfgVehicles" >> _class >> "isBicycle") != 1) then {
		_hitpoints = _object call vehicle_getHitpoints;
		{
			_dam = call generate_new_damage;
			_selection = getText(configFile >> "cfgVehicles" >> _class >> "HitPoints" >> _x >> "name");

			if(_dam > 0) then {
				_dam_array set[count _dam_array,[_selection,_dam]];
			};
		} count _hitpoints;	

		_fuel = (random(DynamicVehicleFuelHigh-DynamicVehicleFuelLow)+DynamicVehicleFuelLow) / 100;
	};
};

_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,_damage,_characterID,_worldspace,[],_dam_array,_fuel,_uid];
_key call server_hiveWrite;

_continue = false;

while {!_continue} do {
	_result		= nil;
	_key		= format["CHILD:388:%1:",_uid];
	_result		= _key call server_hiveReadWrite;
	_outcome	= _result select 0;

	if(_outcome == "PASS") then {
		_continue = true;
	} else {
		sleep 1;
	};
};

_object setVariable["ObjectID",(_result select 1),true];	
_object setVariable["lastUpdate",time];
_object setVariable["CharacterID",_characterID,true];
_object setDamage _damage;

{
	_selection	= _x select 0;
	_dam		= _x select 1;
	if(_selection in dayZ_explosiveParts && _dam > 0.8) then { _dam = 0.8 };
	[_object,_selection,_dam] call object_setFixServer;
} count _dam_array;

_object setFuel _fuel;
_object setvelocity [0,0,1];

PVDZE_serverObjectMonitor set[count PVDZE_serverObjectMonitor,_object];

_object call fnc_veh_ResetEH;

PVDZE_veh_Init = _object;
publicVariable "PVDZE_veh_Init";

diag_log ("PUBLISH: Created " + (_class) + " with ID " + str(_uid));