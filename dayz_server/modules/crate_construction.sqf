private["_spawnChance","_spawnRadius","_markerRadius","_loot","_loot_box","_wait_time","_spawnRoll","_position","_loot_pos","_loot_lists","_clutter"];

_markerRadius 	= 500;
_loot_box 		= "USVehicleBox";
_loot_lists 	= 
	[
		[
			["ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks","MortarBucket","CinderBlocks"]
		],
		[
			["ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack","PartPlankPack","PartPlywoodPack"]
		],
		[
			["metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor"]
		],
		[
			["metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor","metal_floor_kit","ItemWoodFloor"]
		],
		[
			["outhouse_kit","outhouse_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit"]
		],
		[
			["outhouse_kit","outhouse_kit","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","workbench_kit","ItemComboLock","ItemComboLock","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg"]
		],
		[
			["ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","workbench_kit","ItemComboLock","ItemComboLock","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg"]
		],
		[
			["PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","PartGeneric","metal_floor_kit","Itemvault"]
		],
		[
			["ItemWoodWallGarageDoor","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodWallWindowLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallLg","ItemWoodWallGarageDoor","ItemWoodWallWindowLg"]
		],
		[
			["workbench_kit","Itemvault","cinder_wall_kit","ItemComboLock","ItemComboLock","cinder_garage_kit","cinder_garage_kit","cinder_door_kit","cinder_door_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit","cinder_wall_kit"]
		],
		[
			["workbench_kit","ItemWoodStairs","ItemWoodStairs","ItemWoodStairs","wood_shack_kit","wood_shack_kit","wood_shack_kit","deer_stand_kit","deer_stand_kit","ItemWoodLadder","ItemWoodLadder","desert_net_kit","desert_net_kit","ItemWoodLadder","ItemWoodLadder","desert_net_kit","forest_net_kit","forest_net_kit","forest_net_kit","desert_net_kit","desert_net_kit","ItemSandbagLarge","ItemSandbagLarge","Itemvault","Itemvault"]
		]
	];

_loot = _loot_lists call BIS_fnc_selectRandom;

_wait_time 		= 1800; 
_spawnRadius 	= 6500;
_spawnChance	= 75;
_spawnRoll 		= random 100;

if(_spawnRoll > _spawnChance) exitWith {
	diag_log(format["CRATE: NOT SPAWNING CONSTRUCTION CRATE CAUSE OF BAD LUCK"]);
};

_position = [getMarkerPos "center",0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
_loot_pos = [_position,0,(_markerRadius - 100),10,0,2000,0] call BIS_fnc_findSafePos;

diag_log(format["CRATE: SPAWNING CONSTRUCTION CRATE AT %1",_loot_pos]);

_loot_box = createVehicle[_loot_box,_loot_pos,[],0,"CAN_COLLIDE"];
clearMagazineCargoGlobal _loot_box;
clearWeaponCargoGlobal _loot_box;

_clutter = createVehicle["ClutterCutter_small_2_EP1",_loot_pos,[],0,"CAN_COLLIDE"];
_clutter setPos _loot_pos;

{
	_loot_box addMagazineCargoGlobal [_x,1];
} count (_loot select 0);

_loot_box setVariable["permaLoot",true];

RemoteMessage 	= ["radio",format["[RADIO] An Ikea truck has lost it's cargo,it has last been spotted around %1",mapGridPosition _position]];
RemoteMarker 	= ["ItemRadio",_position,"ELLIPSE","ColorGreen",_markerRadius,0.5,_wait_time,"construction_drop_marker"];

publicVariable "RemoteMessage";
publicVariable "RemoteMarker";

sleep _wait_time;
deleteVehicle _loot_box;