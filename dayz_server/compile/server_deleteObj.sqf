private ["_id","_uid","_key","_activatingPlayer"];

_id 				= _this select 0;
_uid 				= _this select 1;
_activatingPlayer 	= _this select 2;

if(typename _id != "SCALAR") then {
	_id = parseNumber _id;
};

if(isNil "_activatingPlayer") then { _activatingPlayer = 0; };
if(isNil "_id") then { _id = 0; };

if(isServer) then {
	if(_id > 0) then {
		_key = format["CHILD:304:%1:",_id];
		_key call server_hiveWrite;
		diag_log format["DELETE: Object with ID: %2 deleted by %1",_activatingPlayer,_id];

		if(_id in localIds) then {
			// only send pv when object is rendered local
			deleteObjects set[count deleteObjects,_id];
			publicVariable "deleteObjects";
			deleteVehicle (serverObjects select _id);
		};

	} else {
		_key = format["CHILD:310:%1:",_uid];
		_key call server_hiveWrite;
		diag_log format["DELETE: %1 Object with UID: %2 deleted by %1",_activatingPlayer,_uid];
	};
};