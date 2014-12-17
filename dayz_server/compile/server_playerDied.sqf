private["_characterID","_minutes","_playerID","_infected","_victim","_victimName","_killer","_killerName","_weapon","_distance","_message","_randmsg","_loc_message","_key","_death_record","_victimGroup"];

_characterID	= _this select 0;
_minutes		= _this select 1;
_victim			= _this select 2;
_playerID		= _this select 3;
_infected		= _this select 4;

_victimName		= name _victim;
_victimGroup	= group _victim;
_royale			= _victim getVariable["Royale",false];

deleteGroup _victimGroup;

_victim setVariable["bodyName",_victimName,true];

sleep 2;

_killer		= _victim getVariable["AttackedBy","nil"];
_killerName	= _victim getVariable["AttackedByName","unknown"];

if((typeName _killer) == "OBJECT") then {
	_weapon		= _victim getVariable["AttackedByWeapon","unknown"];
	_distance	= _victim getVariable["AttackedFromDistance","unknown"];

	if((owner _victim) == (owner _killer)) then  {
		_randmsg = [
			"did not see the point in life any more",
			"thought it was best to end his life",
			"figured his life was worthless",
			"killed himself",
			"should have read a book on physics"
		] call BIS_fnc_selectRandom;
		_message		= format["[DEATH] %1 %2",_victimName,_randmsg];
		_loc_message	= format["PDEATH: %1 (%2) killed himself",_victimName,_playerID];
	} else {

		if(isPlayer _killer) then {
			_killerName = format["[Human] %1",_killerName];
		} else {
			_killerName = format["[AI] %1",_killerName];
		};

		if(_royale) then {
			_message = format["[ROYALE] %1 was killed by %2 with a %3 from about %4m",_victimName,_killerName,_weapon,round(_distance)];
		} else {
			_message = format["[KILL] %1 was killed with a %2 from about %3m",_victimName,_weapon,round(_distance)];
		};
		
		_loc_message	= format["PDEATH: %1 (%5) was killed by %2 with a %3 from %4m",_victimName,_killerName,_weapon,_distance,_playerID];
		_death_record	= [_victimName,_killerName,_weapon,_distance,ServerCurrentTime];

		PlayerDeaths set[count PlayerDeaths,_death_record];
	};

} else {

	_randmsg = [
		"got eaten by zombies, lal noob",
		"was trolled by a zombie xD",
		"became breakfast for a zed",
		"met Chuck Norris as a zombie",
		"tried to tame a zombie"
	] call BIS_fnc_selectRandom;
	_message		= format["[BREAKFAST] %1 %2",_victimName,_randmsg];
	_loc_message	= format["PDEATH: %1 (%2) got killed by a zombie",_victimName,_playerID];

};

RemoteMessage = ["global",_message];
publicVariable "RemoteMessage";

diag_log _loc_message;

RemoteMessage = nil;

_victim setVariable["processedDeath",diag_tickTime];

if(typeName _minutes == "STRING") then {
	_minutes = parseNumber _minutes;
};

if(_characterID != "0") then {
	_key = format["CHILD:202:%1:%2:%3:",_characterID,_minutes,_infected];
	#ifdef DZE_SERVER_DEBUG_HIVE
	diag_log ("HIVE: WRITE: "+ str(_key));
	#endif
	_key call server_hiveWrite;
} else {
	deleteVehicle _victim;
};