private["_spawnChance","_spawnRadius","_markerRadius","_loot","_loot_box","_wait_time","_spawnRoll","_position","_loot_pos","_loot_lists","_clutter"];
 
_markerRadius 	= 500;
_loot_box 		= "RUVehicleBox";
_loot_lists 	= 
	[
		[
			["G36a","G36C","G36_C_SD_eotech","G36K","MP5A5","MP5SD"],
			["20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD","20Rnd_556x45_Stanag","30Rnd_556x45_G36","30Rnd_556x45_G36SD","30Rnd_556x45_Stanag","30Rnd_556x45_StanagSD","30Rnd_9x19_MP5","30Rnd_9x19_MP5SD","15Rnd_9x19_M9SD"]
		],
		[
			["M9SD"],
			["15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD"]
		],
		[
			["BAF_LRR_scoped_W"],
			["5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1","5Rnd_86x70_L115A1"]
		],
		[
			["revolver_gold_EP1"],
			["HandGrenade_West","SmokeShell","SmokeShellGreen","SmokeShellRed","SmokeShellYellow","SmokeShellOrange","SmokeShellPurple","SmokeShellBlue","PipeBomb","7Rnd_45ACP_1911","7Rnd_45ACP_1911","7Rnd_45ACP_1911","7Rnd_45ACP_1911","7Rnd_45ACP_1911"]
		],
		[
			["M107"],
			["10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107","10Rnd_127x99_m107"]
		],
		[
			["DMR_DZ","M4SPR","M8_sharpshooter","M24","M40A3"],
			["20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24","20Rnd_762x51_DMR","5Rnd_762x51_M24"]
		],
		[
			["M16A2","M16A2GL","M16A4","M16A4_GL","M16A4_ACG_GL","M16A4_ACG","M4A1","M4A1_HWS_GL","M4A1_HWS_GL_camo","M4A1_HWS_GL_SD_Camo","M4A1_RCO_GL","M4A1_Aim","M4A1_Aim_camo","M4A1_AIM_SD_camo"],
			["30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]
		],
		[
			["M8_carbine","M8_carbineGL","M8_compact"],
			["30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_StanagSD","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag"]
		]
	];

_loot 			= _loot_lists call BIS_fnc_selectRandom;
_wait_time 		= 1800; 
_spawnRadius 	= 6500;
_spawnChance	= 75;
_spawnRoll 		= random 100;

if(_spawnRoll > _spawnChance) exitWith {
	diag_log(format["CRATE: NOT SPAWNING MILITARY CRATE CAUSE OF BAD LUCK"]);
};

_position = [getMarkerPos "center",0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
_loot_pos = [_position,0,(_markerRadius - 100),10,0,2000,0] call BIS_fnc_findSafePos;

diag_log(format["CRATE: SPAWNING MILITARY CRATE AT %1",_loot_pos]);

_loot_box = createVehicle[_loot_box,_loot_pos,[],0,"CAN_COLLIDE"];
clearMagazineCargoGlobal _loot_box;
clearWeaponCargoGlobal _loot_box;

_clutter = createVehicle["ClutterCutter_small_2_EP1",_loot_pos,[],0,"CAN_COLLIDE"];
_clutter setPos _loot_pos;

{
	_loot_box addWeaponCargoGlobal [_x,1];
} count (_loot select 0);

{
	_loot_box addMagazineCargoGlobal [_x,1];
} count (_loot select 1);

_loot_box setVariable["permaLoot",true];

RemoteMessage 	= ["radio",format["[RADIO] A special forces unit lost it's cargo,reports suggest %1 is it approximate position",mapGridPosition _position]];
RemoteMarker 	= ["ItemRadio",_position,"ELLIPSE","ColorRed",_markerRadius,0.5,_wait_time,"military_drop_marker"];

publicVariable "RemoteMessage";
publicVariable "RemoteMarker";

sleep _wait_time;
deleteVehicle _loot_box;