if(!DZE_ActionInProgress) exitWith {};
private["_isFine","_onLadder","_vehicle","_inVehicle"];

_isFine = "ok";
_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
_vehicle = vehicle player;
_inVehicle = (_vehicle != player);

if(dayz_isSwimming) exitWith {
	DZE_ActionInProgress = false;
	cutText[localize "str_player_26","PLAIN DOWN"];
	_isFine = "Swimming";
	_isFine
};

if(_inVehicle) exitWith {
	DZE_ActionInProgress = false;
	cutText[(localize "str_epoch_player_42"),"PLAIN DOWN"];
	_isFine = "In vehicle";
	_isFine
};

if(_onLadder) exitWith {
	DZE_ActionInProgress = false;
	cutText[localize "str_player_21","PLAIN DOWN"];
	_isFine = "On ladder";
	_isFine
};

/* Dont want this
	if(player getVariable["combattimeout",0] >= time) exitWith {
		DZE_ActionInProgress = false;
		cutText[(localize "str_epoch_player_43"),"PLAIN DOWN"];
		_isFine = "In combat";
		_isFine
	};
*/

_isFine