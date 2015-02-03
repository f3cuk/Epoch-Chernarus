private["_class","_uid","_charID","_object","_worldspace","_key","_allowed"];

_charID 	= _this select 0;
_object 	= _this select 1;
_worldspace = _this select 2;
_class 		= _this select 3;

_allowed = [_object,"Server"] call check_publishobject;
if(!_allowed) exitWith { deleteVehicle _object; };
_uid = _worldspace call dayz_objectUID2;

_worldspace set[0,(_worldspace select 0) call KK_fnc_floatToString];
_worldspace set[1,(_worldspace select 1) call KK_fnc_positionToString];

//Send request
_key = format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,0,_charID,_worldspace,[],[],0,_uid];
_key call server_hiveWrite;

_object setVariable["lastUpdate",time];
_object setVariable["ObjectUID",_uid,true];

[_object,_uid] spawn {

	private["_object","_uid","_key","_result","_outcome","_oid","_busy","_retry"];

	_object		= _this select 0;
	_uid		= _this select 1;

	_retry		= 1;
	_busy		= true;

	while{_busy} do {

		_key 		= format["CHILD:388:%1:",_uid];
		_result 	= _key call server_hiveReadWrite;
		_outcome 	= _result select 0;

		if(_outcome == "PASS") then {
			_oid = _result select 1;
			_busy = false;
		} else {
			diag_log("CUSTOM: trying again to get id for: " + str(_uid));
			_busy = true;
			_retry = _retry + 1;
		};

		sleep .2;

	};

	_object setVariable["ObjectID",_oid,true];

	_oid 		= nil;
	_key 		= nil;
	_result 	= nil;
	_outcome 	= nil;
	_busy 		= nil;
	_retry		= nil;

};

if(DZE_GodModeBase) then {
	_object addEventhandler["HandleDamage",{false}];
} else {
	_object addMPEventhandler["MPKilled",{_this call object_handleServerKilled;}];
};

_object enableSimulation false;

PVDZE_serverObjectMonitor set[count PVDZE_serverObjectMonitor,_object];