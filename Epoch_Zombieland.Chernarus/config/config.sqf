DIFF						= "VETERAN";

dayZ_instance				= 11;
dayzHiveRequest 			= [];
initialized					= false;
dayz_previousID				= 0;
dayz_usesteamid				= true;

dayz_antihack				= 0;
dayz_REsec					= 0;

DZEdebug					= false;

spawnShoremode				= 0;
spawnArea					= 2000;

dayz_paraSpawn				= false;
dayz_minpos					= -1; 
dayz_maxpos					= 16000;
dayz_MapArea				= 14000;

MaxVehicleLimit				= 125;
MaxDynamicDebris			= 0;
DZE_LootSpawnTimer			= 3;

dayz_maxAnimals				= 4;
dayz_tameDogs				= true;
dayz_fullMoonNights			= true;

DynamicVehicleDamageLow 	= 10;
DynamicVehicleDamageHigh 	= 60;

DefaultMagazines			= ["ItemBandage","ItemBandage"];
DefaultWeapons				= ["ItemHatchet_DZE","ItemMatchbox_DZE","ItemKnife","ItemMap","ItemFlashlight","ItemToolbox"];
DefaultBackpack				= "";
DefaultBackpackWeapon		= "";

DZE_SelfTransfuse			= true;
DZE_selfTransfuse_Values 	= [3000,5,300];

DZE_PlotPole 				= [60,90];
DZE_BuildingLimit 			= 500;
DZE_StaticConstructionCount = 1;

DZE_ForceNameTagsInTrader	= true;
DZE_PlayerZed				= false;

DZE_CharacterSwitchTimeout	= 30;
DZE_CharacterMinDistance	= 1000;

DZE_DiagFpsFast				= true;
DZE_DiagVerbose				= true;

DZE_DeathMsgGlobal			= true;

DZE_R3F_WEIGHT				= false;
DZE_APlotforLife			= true;
DZE_modularBuild			= true;
DZE_HeliLift				= true;

dayz_sellDistance_vehicle	= 30;
dayz_sellDistance_boat		= 40;
dayz_sellDistance_air		= 40;

EpochEvents = [
	["any","any","any","any",0,"crash_spawner"],
	["any","any","any","any",10,"crate_military"],
	["any","any","any","any",20,"crate_supply_items"],
	// ["any","any","any","any",30,"flyby"],
	["any","any","any","any",40,"crate_construction"],
	["any","any","any","any",50,"supply_drop"]
];