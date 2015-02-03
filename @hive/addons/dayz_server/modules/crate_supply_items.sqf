private["_spawnChance","_spawnRadius","_markerRadius","_loot","_loot_box","_wait_time","_spawnRoll","_position","_loot_pos","_loot_lists","_clutter"];
 
_markerRadius 	= 250;
_loot_box 		= "SpecialWeaponsBox";
_loot_lists 	=
	[
		[
			["ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaPepsi","ItemSodaPepsi","ItemSodaPepsi","ItemSodaPepsi","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanSardines","FoodCanSardines","FoodCanSardines","FoodCanSardines","FoodMRE","FoodMRE","FoodMRE","FoodMRE","FoodMRE"]
		],
		[
			["ItemSodaRbull","ItemSodaR4z0r","ItemSodaRbull","ItemSodaR4z0r","ItemSodaRbull","ItemSodaR4z0r","ItemSodaRbull","ItemSodaR4z0r","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked","FoodbaconCooked","FoodchickenCooked"]
		],
		[
			["Skin_Camo1_DZ","Skin_CZ_Soldier_Sniper_EP1_DZ","Skin_CZ_Special_Forces_GL_DES_EP1_DZ","Skin_Drake_Light_DZ","Skin_FR_OHara_DZ","Skin_FR_Rodriguez_DZ","Skin_Graves_Light_DZ","Skin_Sniper1_DZ","Skin_Soldier1_DZ","Skin_Soldier_Bodyguard_AA12_PMC_DZ"]
		],
		[
			["Skin_Functionary1_EP1_DZ","Skin_Pilot_EP1_DZ","Skin_Priest_DZ","Skin_Rocker1_DZ","Skin_Rocker2_DZ","Skin_RU_Policeman_DZ","Skin_RU_Policeman_DZ","Skin_Pilot_EP1_DZ","Skin_Functionary1_EP1_DZ","Skin_Priest_DZ"]
		],
		[
			["Skin_Bandit1_DZ","Skin_Bandit2_DZ","Skin_BanditW1_DZ","Skin_GUE_Commander_DZ","Skin_GUE_Soldier_2_DZ","Skin_GUE_Soldier_Crew_DZ","Skin_GUE_Soldier_Sniper_DZ","Skin_Ins_Soldier_GL_DZ","Skin_TK_INS_Soldier_EP1_DZ","Skin_TK_INS_Warlord_EP1_DZ","Skin_GUE_Commander_DZ"]
		],
		[
			["ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemSodaCoke","ItemSodaCoke","ItemSodaCoke","ItemSodaPepsi","ItemSodaPepsi","ItemSodaPepsi","ItemSodaPepsi","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanBakedBeans","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanPasta","FoodCanSardines","FoodCanSardines","FoodCanSardines","FoodCanSardines","FoodMRE","FoodMRE","FoodMRE","FoodMRE","FoodMRE","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemTent","ItemJerrycan","ItemTent","ItemJerrycan","ItemTent","ItemJerrycan"]
		],
		[
			["ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine","ItemAntibiotic","ItemBandage","ItemBloodbag","ItemEpinephrine","ItemMorphine","ItemPainkiller","ItemBloodbag","ItemBandage","ItemBandage","ItemMorphine"]
		]
	];

_loot 			= _loot_lists call BIS_fnc_selectRandom;
_wait_time 		= 1800; 
_spawnRadius 	= 6500;
_spawnChance	= 75;
_spawnRoll 		= random 100;

if(_spawnRoll > _spawnChance) exitWith {
	diag_log(format["CRATE: NOT SPAWNING RANDOM CRATE CAUSE OF BAD LUCK"]);
};

_position = [getMarkerPos "center",0,_spawnRadius,10,0,2000,0] call BIS_fnc_findSafePos;
_loot_pos = [_position,0,(_markerRadius - 100),10,0,2000,0] call BIS_fnc_findSafePos;

diag_log(format["CRATE: SPAWNING RANDOM CRATE AT %1",_loot_pos]);

_loot_box = createVehicle[_loot_box,_loot_pos,[],0,"NONE"];

clearMagazineCargoGlobal _loot_box;
clearWeaponCargoGlobal _loot_box;

_clutter = createVehicle["ClutterCutter_small_2_EP1",_loot_pos,[],0,"CAN_COLLIDE"];
_clutter setPos _loot_pos;

{
	_loot_box addMagazineCargoGlobal [_x,1];
} count (_loot select 0);

_loot_box setVariable["permaLoot",true];

RemoteMessage 	= ["radio",format["[RADIO] UN Agency dropped in some supplies around %1",mapGridPosition _position]];
RemoteMarker 	= ["ItemRadio",_position,"ELLIPSE","ColorBlue",_markerRadius,0.5,_wait_time,"supply_drop_marker"];

publicVariable "RemoteMessage";
publicVariable "RemoteMarker";

sleep _wait_time;
deleteVehicle _loot_box;