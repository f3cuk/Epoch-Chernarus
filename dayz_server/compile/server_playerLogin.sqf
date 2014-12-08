private["_result","_continue","_isInfected","_hiveVer","_isHiveOk","_playerID","_playerObj","_key","_charID","_playerName","_backpack","_isNew","_inventory","_survival","_model","_mags","_wpns","_bcpk","_config","_newPlayer"];

#ifdef DZE_SERVER_DEBUG
diag_log ("STARTING LOGIN: " + str(_this));
#endif

_playerID	= _this select 0;
_playerObj	= _this select 1;
_playerName	= name _playerObj;

if(_playerName == '__SERVER__' || _playerID == '' || local player || typeName _playerObj != "OBJECT" || _playerName == "Error: No vehicle") exitWith {};

if(isNil "sm_done") exitWith { 
#ifdef DZE_SERVER_DEBUG
	diag_log ("Login cancelled, server is not ready. " + str(_playerObj)); 
#endif
};

if(count _this > 2) then {
	dayz_players = dayz_players - [_this select 2];
};

_inventory	= [];
_backpack	= [];
_survival	= [0,0,0];
_isInfected	= 0;
_model		= "";

if(_playerID == "") then {
	_playerID = getPlayerUID _playerObj;
};

if((_playerID == "") || (isNil "_playerID")) exitWith {
#ifdef DZE_SERVER_DEBUG
	diag_log ("LOGIN FAILED: Player [" + _playerName + "] has no login ID");
#endif
};

#ifdef DZE_SERVER_DEBUG
diag_log ("LOGIN ATTEMPT: " + str(_playerID) + " " + _playerName);
#endif

_continue = false;

while {!_continue} do {
	_result		= nil;
	_key 		= format["CHILD:101:%1:%2:%3:%4:",_playerID,dayZ_instance,_playerName,_this select 2];
	_result 	= _key call server_hiveReadWrite;

	if((_result select 0) == "PASS") then {
		diag_log format["[LOGIN ATTEMPT] %1 success (%2)",_playerName,_result];
		_continue = true;
	} else {
		diag_log format["[LOGIN ATTEMPT] %1 failed to login (%2)",_playerName,_result];
		sleep 1;
	};
};

if(isNull _playerObj || !isPlayer _playerObj) exitWith {
#ifdef DZE_SERVER_DEBUG
	diag_log ("LOGIN RESULT: Exiting, player object null: " + str(_playerObj));
#endif
};

_newPlayer	= _result select 1;
_charID		= _result select 2;
_isNew		= count _result < 7;

#ifdef DZE_SERVER_DEBUG
diag_log ("LOGIN RESULT: " + str(_result));
#endif

_hiveVer = 0;

if(!_isNew) then {
	_inventory	= _result select 4;
	_backpack	= _result select 5;
	_survival	= _result select 6;
	_model		= _result select 7;
	_hiveVer	= _result select 8;

	if(!(_model in AllPlayers)) then {
		_model = "Survivor2_DZ";
	};
} else {
	if(DZE_PlayerZed) then {
		_isInfected = _result select 3;
	} else {
		_isInfected = 0;
	};
	_model		= _result select 4;
	_hiveVer	= _result select 5;

	if(isNil "_model") then {
		_model = "Survivor2_DZ";
	} else {
		if(_model == "") then {
			_model = "Survivor2_DZ";
		};
	};

	if(_isInfected != 1) then {
		_config = (configFile >> "CfgSurvival" >> "Inventory" >> "Default");
		_mags = getArray (_config >> "magazines");
		_wpns = getArray (_config >> "weapons");
		_bcpk = getText (_config >> "backpack");

		if(!isNil "DefaultMagazines") then {
			_mags = DefaultMagazines;
		};
		if(!isNil "DefaultWeapons") then {
			_wpns = DefaultWeapons;
		};
		if(!isNil "DefaultBackpack") then {
			_bcpk = DefaultBackpack;
		};

		_key = format["CHILD:203:%1:%2:%3:",_charID,[_wpns,_mags],[_bcpk,[],[]]];
		_key call server_hiveWrite;
	};
};

#ifdef DZE_SERVER_DEBUG
diag_log ("LOGIN LOADED: " + str(_playerObj) + " Type: " + (typeOf _playerObj) + " at location: " + ([_playerObj] call FNC_GetPos));
#endif

_isHiveOk = false;
if(_hiveVer >= dayz_hiveVersionNo) then {
	_isHiveOk = true;
};

if(worldName == "chernarus") then {
	([4654,9595,0] nearestObject 145259) setDamage 1;
	([4654,9595,0] nearestObject 145260) setDamage 1;
};

dayzPlayerLogin = [_charID,_inventory,_backpack,_survival,_isNew,dayz_versionNo,_model,_isHiveOk,_newPlayer,_isInfected];
(owner _playerObj) publicVariableClient "dayzPlayerLogin";