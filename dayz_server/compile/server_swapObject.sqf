private["_activatingplayerUID","_class","_uid","_charID","_object","_worldspace","_key","_allowed","_obj","_objectID","_objectUID","_proceed","_activatingplayer"];

_charID					= _this select 0;
_object					= _this select 1;
_worldspace				= _this select 2;
_class					= _this select 3;
_obj					= _this select 4;
_activatingplayer		= _this select 5;
_activatingplayerUID	= (getPlayerUID _activatingplayer);

_proceed	= false;
_objectID  	= "0";
_objectUID	= "0";

if(typeName _obj == "OBJECT") then {
	_objectID 	= _obj getVariable["ObjectID","0"];
	_objectUID	= _obj getVariable["ObjectUID","0"];

	if !(DZE_GodModeBase) then {
		_obj removeAllMPEventHandlers "MPKilled";
	};

	deleteVehicle _obj;
	_proceed = true;
};

if(typeName _obj == "STRING") then {
	_objectID 	= _obj;
	_objectUID	= 0;
	_proceed = true;
};

if(_objectID == "0") then { 
	_proceed = false;
} else {
	[_objectID,_objectUID,_activatingplayer] call server_deleteObj;
};

_allowed = [_object,"Server"] call check_publishobject;

if(!_allowed || !_proceed) exitWith { 
	if(!isNull(_object)) then {
		deleteVehicle _object; 
	};
	diag_log ("Invalid object swap by playerUID:"+ str(_activatingplayerUID));
};

_uid = _worldspace call dayz_objectUID2;

_worldspace set[0,(_worldspace select 0) call KK_fnc_floatToString];
_worldspace set[1,(_worldspace select 1) call KK_fnc_positionToString];

_object setVariable["CharacterID",_charID,true];
_object setVariable["OEMPos",call compile (_worldspace select 1),true];

_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,0,_charID,_worldspace,[],[],0,_uid];
_key call server_hiveWrite;

[_object,_uid] spawn {

	private["_uid","_object","_continue","_result","_key","_outcome"];

	_object		= _this select 0;
	_uid		= _this select 1;
	_continue	= false;

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

	_object setVariable["ObjectID",(_result select 1),true];

	diag_log format["PUBLISH: Assigned %1 to Object with UID %2",(_result select 1),_uid];

};

_object setVariable["lastUpdate",time];
_object setVariable["ObjectUID",_uid,true];

if(DZE_GodModeBase) then {
	_object addEventhandler["HandleDamage",{false}];
} else {
	_object addMPEventhandler["MPKilled",{_this call object_handleServerKilled;}];
};
_object enableSimulation false;

PVDZE_serverObjectMonitor set[count PVDZE_serverObjectMonitor,_object];

diag_log ("PUBLISH: " + str(_activatingPlayer) + " upgraded " + (_class) + " with ID " + str(_uid));