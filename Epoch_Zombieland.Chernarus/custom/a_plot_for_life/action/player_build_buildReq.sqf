private["_passArray","_missing","_hasrequireditem","_require","_hastoolweapon","_hasbuilditem","_checkMag","_checkTools","_reason","_text"];

if(!DZE_ActionInProgress) exitWith {};

_require 			= _this select 0;
_text 				= _this select 1;
_checkMag 			= _this select 2;
_checkTools 		= _this select 3;

_missing 			= "";
_hasrequireditem 	= true;
_reason 			= "ok";
_passArray 			= [];

{
	_hastoolweapon = _x in weapons player;
	if(!_hastoolweapon) exitWith {
		_hasrequireditem = false; _missing = getText (configFile >> "cfgWeapons" >> _x >> "displayName");
	};
} count _require;

_hasbuilditem 	= DZE_buildItem in magazines player;
_passArray 		= [_hasrequireditem,_reason];

if(_checkMag) then {
	if(!_hasbuilditem) exitWith {
		DZE_ActionInProgress = false;
		cutText[format[(localize "str_player_31"),_text,"build"] ,"PLAIN DOWN"];
		_reason = "missing item";
		_passArray
	};
};

if(_checkTools) then {
	if(!_hasrequireditem) exitWith {
		DZE_ActionInProgress = false;
		cutText[format[(localize "str_epoch_player_137"),_missing] ,"PLAIN DOWN"];
		_reason = "missing tools";
		_passArray
	};
};

_passArray