if(!DZE_ActionInProgress) exitWith {};

private["_abort","_reason","_distance","_needNear","_isNear","_pos"];

_abort 		= false;
_reason 	= "";
_needNear 	= getArray (configFile >> "CfgMagazines" >> DZE_buildItem >> "ItemActions" >> "Build" >> "neednearby");

_pos = [player] call FNC_GetPos;

{
	if(_x == "fire") exitWith {
		_distance 	= 3;
		_isNear 	= {inflamed _x} count (_pos nearObjects _distance);
		if(_isNear == 0) then {
			_abort = true;
			_reason = "fire";
		};
	};
	if(_x == "workshop") exitWith {
		_distance 	= 3;
		_isNear 	= count (nearestObjects[_pos,["Wooden_shed_DZ","WoodShack_DZ","WorkBench_DZ"],_distance]);
		if(_isNear == 0) then {
			_abort = true;
			_reason = "workshop";
		};
	};
	if(_x == "workshop") exitWith {
		_distance = 30;
		_isNear = count (nearestObjects[_pos,dayz_fuelsources,_distance]);
		if(_isNear == 0) then {
			_abort = true;
			_reason = "fuel tank";
		};
	};
} count _needNear;

if(_abort) exitWith {
	cutText[format[(localize "str_epoch_player_135"),_reason,_distance],"PLAIN DOWN"];
	DZE_ActionInProgress = false;
};