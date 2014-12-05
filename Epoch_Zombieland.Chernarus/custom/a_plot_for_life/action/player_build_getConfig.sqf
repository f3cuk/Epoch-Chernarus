if(!DZE_ActionInProgress) exitWith {};

private["_passArray","_classname","_classnametmp","_require","_text","_ghost","_lockable","_requireplot","_isAllowedUnderGround","_offset","_isPole","_isLandFireDZ"];

_passArray 		= [];
_require 		= getArray (configFile >> "cfgMagazines" >> DZE_buildItem >> "ItemActions" >> "Build" >> "require");
_classname 		= getText (configFile >> "CfgMagazines" >> DZE_buildItem >> "ItemActions" >> "Build" >> "create");
_classnametmp 	= _classname;
_text 			= getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
_ghost 			= getText (configFile >> "CfgVehicles" >> _classname >> "ghostpreview");

_lockable = 0;

if(isNumber (configFile >> "CfgVehicles" >> _classname >> "lockable")) then {
	_lockable = getNumber(configFile >> "CfgVehicles" >> _classname >> "lockable");
};

_requireplot = DZE_requireplot;

if(isNumber (configFile >> "CfgVehicles" >> _classname >> "requireplot")) then {
	_requireplot = getNumber(configFile >> "CfgVehicles" >> _classname >> "requireplot");
};

_isAllowedUnderGround = 1;

if(isNumber (configFile >> "CfgVehicles" >> _classname >> "nounderground")) then {
	_isAllowedUnderGround = getNumber(configFile >> "CfgVehicles" >> _classname >> "nounderground");
};

_offset = 	getArray (configFile >> "CfgVehicles" >> _classname >> "offset");

if((count _offset) <= 0) then {
	_offset = [0,1.5,0];
};

_isPole 		= (_classname == "Plastic_Pole_EP1_DZ");
_isLandFireDZ 	= (_classname == "Land_Fire_DZ");
_passArray 		= [_classname,_classnametmp,_require,_text,_ghost,_lockable,_requireplot,_isAllowedUnderGround,_offset,_isPole,_isLandFireDZ];
_passArray