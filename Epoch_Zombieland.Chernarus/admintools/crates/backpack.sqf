private ["_LocalOrGlobal","_spawnCrate","_crateName","_pos","_classname","_dir","_selectDelay"];
_LocalOrGlobal = _this select 0;

// Name of this crate
_crateName = "Backpack Crate";

// Crate type
_classname = "USOrdnanceBox";

// Tool use logger
if(logMajorTool) then {
	usageLogger = format["%1 %2 -- has spawned a %3 %4",name player,getPlayerUID player,_LocalOrGlobal,_crateName];
	[] spawn {publicVariable "usageLogger";};
};

// Tool use broadcaster
if(!((getPlayerUID player) in SuperAdminList) && broadcastToolUse) then {
	useBroadcaster = format["%1 -- has spawned a %2 %3",name player,_LocalOrGlobal,_crateName];
	[] spawn {publicVariableServer "useBroadcaster";};
};

// Location of player and crate
_dir = getdir player;
_pos = getposATL player;
_pos = [(_pos select 0)+1*sin(_dir),(_pos select 1)+1*cos(_dir), (_pos select 2)];

if(_LocalOrGlobal == "local") then {
	_spawnCrate = _classname createVehicleLocal _pos;	
} else {
	_spawnCrate = createVehicle [_classname, _pos, [], 0, "CAN_COLLIDE"];
};

_spawnCrate setDir _dir;
_spawnCrate setposATL _pos;

// Remove default items/weapons from current crate before adding custom gear
clearWeaponCargoGlobal _spawnCrate;
clearMagazineCargoGlobal _spawnCrate;
clearBackpackCargoGlobal _spawnCrate;

_spawnCrate addBackpackCargoGlobal ["DZ_Backpack_EP1", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_British_ACU", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_CivilBackpack_EP1", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_CompactPack_EP1", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_GunBag_EP1", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_LargeGunBag_EP1", 10];
_spawnCrate addBackpackCargoGlobal ["DZ_TK_Assault_Pack_EP1", 10];

// Send text to spawner only
titleText [format[_crateName + " spawned!"],"PLAIN DOWN"]; titleFadeOut 4;