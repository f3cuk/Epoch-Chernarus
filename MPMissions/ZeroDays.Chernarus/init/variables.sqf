CurrencyName 		= "gold coins";
CurrencyAbbr		= "Coins";
dayz_wealth			= -1;
targetvault 		= nil;

Bandit1_DZ			= "Bandit1_DZ";
Bandit2_DZ			= "Bandit2_DZ";
BanditW1_DZ			= "BanditW1_DZ";
BanditW2_DZ			= "BanditW2_DZ";
Survivor1_DZ		= "Survivor2_DZ";
Survivor2_DZ		= "Survivor2_DZ";
SurvivorW2_DZ		= "SurvivorW2_DZ";
SurvivorW3_DZ		= "SurvivorW2_DZ";
Sniper1_DZ			= "Sniper1_DZ";
Camo1_DZ			= "Camo1_DZ";
Soldier1_DZ			= "Soldier1_DZ";
Rocket_DZ			= "Rocket_DZ";

gear_done			= false;

AllPlayers			= ["Survivor2_DZ","SurvivorWcombat_DZ","SurvivorWdesert_DZ","SurvivorWurban_DZ","SurvivorWsequishaD_DZ","SurvivorWsequisha_DZ","SurvivorWpink_DZ","SurvivorW3_DZ","SurvivorW2_DZ","Bandit1_DZ","Bandit2_DZ","BanditW1_DZ","BanditW2_DZ","Soldier_Crew_PMC","Sniper1_DZ","Camo1_DZ","Soldier1_DZ","Rocket_DZ","Rocker1_DZ","Rocker2_DZ","Rocker3_DZ","Rocker4_DZ","Priest_DZ","Functionary1_EP1_DZ","GUE_Commander_DZ","Ins_Soldier_GL_DZ","Haris_Press_EP1_DZ","Pilot_EP1_DZ","RU_Policeman_DZ","pz_policeman","pz_suit1","pz_suit2","pz_worker1","pz_worker2","pz_worker3","pz_doctor","pz_teacher","pz_hunter","pz_villager1","pz_villager2","pz_villager3","pz_priest","Soldier_TL_PMC_DZ","Soldier_Sniper_PMC_DZ","Soldier_Bodyguard_AA12_PMC_DZ","Drake_Light_DZ","CZ_Special_Forces_GL_DES_EP1_DZ","TK_INS_Soldier_EP1_DZ","TK_INS_Warlord_EP1_DZ","FR_OHara_DZ","FR_Rodriguez_DZ","CZ_Soldier_Sniper_EP1_DZ","Graves_Light_DZ","GUE_Soldier_MG_DZ","GUE_Soldier_Sniper_DZ","GUE_Soldier_Crew_DZ","GUE_Soldier_CO_DZ","GUE_Soldier_2_DZ","TK_Special_Forces_MG_EP1_DZ","TK_Soldier_Sniper_EP1_DZ","TK_Commander_EP1_DZ","RU_Soldier_Crew_DZ","INS_Lopotev_DZ","INS_Soldier_AR_DZ","INS_Soldier_CO_DZ","INS_Bardak_DZ","INS_Worker2_DZ"];
MeleeWeapons		= ["MeleeFishingPole","MeleeCrowbar","MeleeBaseBallBatNails","MeleeBaseBallBatBarbed","MeleeBaseBallBat","Crossbow_DZ","MeleeSledge","MeleeMachete","MeleeHatchet_DZE"];
meatraw				= ["FoodSteakRaw","FoodmeatRaw","FoodbeefRaw","FoodmuttonRaw","FoodchickenRaw","FoodrabbitRaw","FoodbaconRaw","ItemTrout","ItemSeaBass","ItemTuna"];
exceptionsraw		= ["ItemTuna"];
meatcooked			= ["FoodSteakCooked","FoodmeatCooked","FoodbeefCooked","FoodmuttonCooked","FoodchickenCooked","FoodrabbitCooked","FoodbaconCooked","ItemTroutCooked","ItemSeaBassCooked","ItemTunaCooked"];
no_output_food		= ["FoodMRE","FoodPistachio","FoodNutmix","FoodBioMeat"]+meatcooked+meatraw;
badfood				= ["FoodBioMeat","FoodCanUnlabeled"];
food_with_output	= ["FoodCanBakedBeans","FoodCanSardines","FoodCanFrankBeans","FoodCanPasta","FoodCanGriff","FoodCanBadguy","FoodCanBoneboy","FoodCanCorn","FoodCanCurgon","FoodCanDemon","FoodCanFraggleos","FoodCanHerpy","FoodCanOrlok","FoodCanPowell","FoodCanTylers",	"FoodCanUnlabeled"];
food_output			= ["TrashTinCan","TrashTinCan","TrashTinCan","TrashTinCan","FoodCanGriffEmpty","FoodCanBadguyEmpty","FoodCanBoneboyEmpty","FoodCanCornEmpty","FoodCanCurgonEmpty","FoodCanDemonEmpty","FoodCanFraggleosEmpty","FoodCanHerpyEmpty","FoodCanOrlokEmpty","FoodCanPowellEmpty","FoodCanTylersEmpty",	"FoodCanUnlabeledEmpty"];
no_output_drink		= ["ItemWaterbottle","ItemWaterbottleBoiled"];
drink_with_output	= ["ItemSoda","ItemSodaRbull","ItemSodaOrangeSherbet","ItemSodaCoke","ItemSodaPepsi","ItemSodaMdew","ItemSodaMtngreen","ItemSodaR4z0r","ItemSodaClays","ItemSodaSmasht","ItemSodaDrwaste","ItemSodaLemonade","ItemSodaLvg","ItemSodaMzly","ItemSodaRabbit"];
drink_output		= ["ItemSodaEmpty","ItemSodaEmpty","ItemSodaEmpty","ItemSodaCokeEmpty","ItemSodaPepsiEmpty","ItemSodaMdewEmpty","ItemSodaMtngreenEmpty","ItemSodaR4z0rEmpty","ItemSodaClaysEmpty","ItemSodaSmashtEmpty","ItemSodaDrwasteEmpty","ItemSodaLemonadeEmpty","ItemSodaLvgEmpty","ItemSodaMzlyEmpty",	"ItemSodaRabbitEmpty"];
boil_tin_cans		= ["TrashTinCan","FoodCanGriffEmpty","FoodCanBadguyEmpty","FoodCanBoneboyEmpty","FoodCanCornEmpty","FoodCanCurgonEmpty","FoodCanDemonEmpty","FoodCanFraggleosEmpty","FoodCanHerpyEmpty","FoodCanOrlokEmpty","FoodCanPowellEmpty","FoodCanTylersEmpty","FoodCanUnlabeledEmpty","ItemSodaEmpty","ItemSodaCokeEmpty","ItemSodaPepsiEmpty","ItemSodaMdewEmpty","ItemSodaMtngreenEmpty","ItemSodaR4z0rEmpty","ItemSodaClaysEmpty","ItemSodaSmashtEmpty","ItemSodaDrwasteEmpty","ItemSodaLemonadeEmpty","ItemSodaLvgEmpty","ItemSodaMzlyEmpty","ItemSodaRabbitEmpty"];
localLights 		= ["LAND_ASC_Wall_Lamp_New","LAND_ASC_Wall_Lamp_Old","ASC_EU_LHV_lampa_sidlconc","Land_Fire_barrel_burning","ASC_EU_BulbBLUB","ASC_EU_BulbYELB","ASC_EU_BulbGRNB","ASC_EU_BulbPURB","ASC_EU_BulbREDB","LAND_ASC_runway_Yellowlight","LAND_ASC_runway_Bluelight","ASC_runway_BluelightB","ASC_runway_YellowlightB","MAP_fluor_lamp","MAP_lantern","MAP_Light_BathRoom","MAP_light_kitchen_03","Misc_Wall_lamp","Red_Light_Blinking_EP1","ASC_EU_LHVIndE","ASC_EU_LHVIndB","ASC_EU_LHVIndZ","ASC_EU_LHVInd","ASC_EU_LHVSidl3","ASC_EU_LHVSidl2","ASC_EU_LHVSidl1","ASC_EU_LHVStre2","ASC_EU_LHVStre1","ASC_EU_LHVOld","SearchLight","Land_Ind_IlluminantTower","ASC_EU_BulbBLUP","ASC_EU_BulbGRNP","ASC_EU_BulbPURP","ASC_EU_BulbREDP","ASC_EU_BulbYELP","Land_Campfire_burning"];


dayz_combination	= "";
dayz_humanitytarget	= "";
dayz_combatLog		= "";

canRoll				= true;
canbuild			= true;

dayZ_partClasses	= ["PartFueltank","PartWheel","PartEngine"];
dayZ_explosiveParts	= ["palivo","motor"];
SleepFood			= 2160;
SleepWater			= 1440;
SleepTemperatur		= 90 / 100;

allowConnection				= false;
isSinglePlayer				= false;
PVDZE_serverObjectMonitor	= [];
PlayerDeaths				= [];

dayz_Locations				= [];
dayz_locationsActive		= [];

Dayz_GUI_R	= 0.38;
Dayz_GUI_G	= 0.63;
Dayz_GUI_B	= 0.26;

dayz_resetSelfActions = {
	vault_currency_w				= -1;
	vault_currency_d				= -1;
	s_givemoney_dialog				= -1;
	target_vault					= -1;
	s_crate_money					= -1;
	s_player_fire					= -1;
	s_player_cook					= -1;
	s_player_boil					= -1;
	s_player_fireout				= -1;
	s_player_butcher				= -1;
	s_player_packtent				= -1;
	s_player_packvault				= -1;
	s_player_lockvault				= -1;
	s_player_unlockvault			= -1;
	s_player_fillwater				= -1;
	s_player_fillwater2				= -1;
	s_player_fillfuel				= -1;
	s_player_grabflare				= -1;
	s_player_dropflare				= -1;
	s_player_callzombies			= -1;
	s_player_showname				= -1;
	s_player_debuglootpos			= -1;
	s_player_pzombiesattack			= -1;
	s_player_pzombiesvision			= -1;
	s_player_pzombiesfeed			= -1;
	s_player_removeflare			= -1;
	s_player_painkiller				= -1;
	s_player_studybody				= -1;
	s_player_tamedog				= -1;
	s_player_madsci_crtl			= -1;
	s_player_parts_crtl				= -1;
	s_build_Sandbag1_DZ				= -1;
	s_build_Hedgehog_DZ				= -1;
	s_build_Wire_cat1				= -1;
	s_player_deleteBuild			= -1;
	s_player_forceSave				= -1;
	s_player_checkGear				= -1;
	s_player_flipveh				= -1;
	s_player_stats					= -1;
	s_player_sleep					= -1;
	s_player_movedog				= -1;
	s_player_speeddog				= -1;
	s_player_calldog				= -1;
	s_player_feeddog				= -1;
	s_player_waterdog				= -1;
	s_player_staydog				= -1;
	s_player_trackdog				= -1;
	s_player_barkdog				= -1;
	s_player_warndog				= -1;
	s_player_followdog				= -1;
	s_player_repair_crtl			= -1;
	s_player_information			= -1;
	s_player_fuelauto 				= -1;
	s_player_fuelauto2 				= -1;
	s_player_fillgen				= -1;
	s_player_upgrade_build			= -1;
	s_player_maint_build			= -1;
	s_player_downgrade_build		= -1;
	s_player_towing					= -1;
	s_halo_action					= -1;
	s_player_SurrenderedGear		= -1;
	s_player_maintain_area			= -1;
	s_player_maintain_area_preview	= -1;
	s_player_heli_lift				= -1;
	s_player_heli_detach			= -1;
	s_player_lockUnlock_crtl		= -1;
	s_player_toggleSnap 			= -1;
	s_player_toggleSnapSelect		= -1;
	s_player_toggleSnapSelectPoint	= [];
	snapActions						= -1;
	s_player_plot_boundary_on		= -1;
	s_player_plot_boundary_off		= -1;
	s_player_plot_take_ownership	= -1;
	s_player_holderPickup			= -1;
};

call dayz_resetSelfActions;

s_player_lastTarget		= [objNull,objNull,objNull,objNull,objNull];
s_player_repairActions	= [];
s_player_lockunlock		= [];

s_player_madsci			= [];
s_player_parts			= [];
s_player_combi			= [];

snapGizmos				= [];
snapGizmosNearby		= [];

r_interrupt				= false;
r_doLoop				= false;
r_self					= false;
r_self_actions			= [];
r_drag_sqf				= false;
r_action				= false;
r_action_unload			= false;
r_player_handler		= false;
r_player_handler1		= false;
r_player_dead			= false;
r_player_unconscious	= false;
r_player_infected		= false;
r_player_injured		= false;
r_player_inpain			= false;
r_player_loaded			= false;
r_player_cardiac		= false;
r_fracture_legs			= false;
r_fracture_arms			= false;
r_player_vehicle		= player;
r_player_blood			= 12000;
r_player_lowblood		= false;
r_player_timeout		= 0;
r_player_bloodTotal		= r_player_blood;
r_public_blood			= r_player_blood;
r_player_bloodDanger	= r_player_bloodTotal * 0.2;
r_player_actions		= [];
r_handlerCount			= 0;
r_action_repair			= false;
r_action_targets		= [];
r_pitchWhine			= false;
r_isBandit				= false;
isInTraderCity			= false;
NORRN_dropAction		= -1;
DZE_PROTOBOX			= objNull;

r_player_actions2		= [];
r_action2				= false;
r_player_lastVehicle	= objNull;
r_player_lastSeat		= [];
r_player_removeActions2	= {
	if(!isNull r_player_lastVehicle) then { 
		{
			r_player_lastVehicle removeAction _x;
		} count r_player_actions2;

		r_player_actions2	= [];
		r_action2			= false; 
	};
};

USEC_woundHit 			= ["","body","hands","legs","head_hit"];
DAYZ_woundHit 			= [["body","hands","legs","head_hit"],[ 0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,2,2,3]];
DAYZ_woundHit_ok 		= [["body","hands","legs"],[0,0,0,0,0,1,1,1,2,2]];
DAYZ_woundHit_dog		= [["body","hands","legs"],[0,0,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2]];
USEC_MinorWounds 		= ["hands","legs"];
USEC_woundPoint			= [["Pelvis","aimpoint"],["aimpoint"],["lelbow","relbow"],["RightFoot","LeftFoot"],["neck","pilot"]];
USEC_typeOfWounds		= ["Pelvis","aimpoint","lelbow","relbow","RightFoot","LeftFoot","neck","pilot"];
DZE_vehicleZwounds		= ["sklo predni L","sklo predni P","sklo zadni","sklo zadni L","sklo zadni P","sklo P","Glass1","Glass2","Glass3","Glass4","Glass5","Glass6"];
DZE_HeliAllowTowFrom	= ["baf_merlin_dze","ch53_dze","ch_47f_baf","ch_47f_ep1","ch_47f_ep1_dz","ch_47f_ep1_dze","l39_tk_ep1","mi17_civilian_dz","mi17_dze","mv22_dz","uh1h_dze","uh1h_tk_ep1","uh1y","uh1y_dze","uh60m_ep1_dze",	"MH60S_DZE"];
DZE_HeliAllowToTow		= ["armoredsuv_pmc_dz","armoredsuv_pmc_dze","atv_cz_ep1","atv_us_ep1","baf_atv_d","baf_atv_w","baf_fv510_d","baf_fv510_w","baf_jackal2_gmg_d","baf_jackal2_gmg_w","baf_jackal2_l2a1_d","baf_jackal2_l2a1_w","baf_merlin_dze","baf_offroad_d","baf_offroad_w","bmp2_ambul_cdf","bmp2_ambul_ins","bmp2_cdf","bmp2_gue","bmp2_hq_cdf","bmp2_hq_ins","bmp2_hq_tk_ep1","bmp2_ins","bmp2_tk_ep1","bmp2_un_ep1","bmp3","brdm2_atgm_cdf","brdm2_atgm_ins","brdm2_atgm_tk_ep1","brdm2_atgm_tk_gue_ep1","brdm2_cdf","brdm2_gue","brdm2_hq_gue","brdm2_hq_tk_gue_ep1","brdm2_ins","brdm2_tk_ep1","brdm2_tk_gue_ep1","btr40_mg_tk_gue_ep1","btr40_mg_tk_ins_ep1","btr40_tk_gue_ep1","btr40_tk_ins_ep1","btr60_tk_ep1","car_hatchback","car_sedan","chukar","chukar_ep1","datsun1_civil_1_open","datsun1_civil_2_covered","datsun1_civil_3_open","fishing_boat","gaz_vodnik","gaz_vodnik_dz","gaz_vodnik_dz_lm","gaz_vodnik_dz_vlm","gaz_vodnik_dze","gaz_vodnik_hmg","gaz_vodnik_medevac","glt_m300_lt","glt_m300_st","gnt_c185","gnt_c185c","gnt_c185e","gnt_c185f","gnt_c185r","gnt_c185t","gnt_c185u","grad_cdf","grad_ins","grad_ru","grad_tk_ep1","hilux1_civil_1_open","hilux1_civil_2_covered","hilux1_civil_3_open","hilux1_civil_3_open_ep1","hmmwv","hmmwv_ambulance","hmmwv_ambulance_cz_des_ep1","hmmwv_ambulance_des_ep1","hmmwv_armored","hmmwv_avenger","hmmwv_avenger_des_ep1","hmmwv_des_ep1","hmmwv_dz","hmmwv_m1035_des_ep1","hmmwv_m1151_m2_cz_des_ep1","hmmwv_m1151_m2_cz_des_ep1_dz","hmmwv_m1151_m2_cz_des_ep1_dze","hmmwv_m1151_m2_des_ep1","hmmwv_m2","hmmwv_m998_crows_m2_des_ep1","hmmwv_m998_crows_mk19_des_ep1","hmmwv_m998a2_sov_des_ep1","hmmwv_m998a2_sov_des_ep1_dz","hmmwv_m998a2_sov_des_ep1_dze","hmmwv_mk19","hmmwv_mk19_des_ep1","hmmwv_terminal_ep1","hmmwv_tow","hmmwv_tow_des_ep1","ikarus","ikarus_tk_civ_ep1","jetskiyanahui_blue","jetskiyanahui_green","jetskiyanahui_red","jetskiyanahui_yellow","kamaz","kamazopen","kamazreammo","kamazrefuel","kamazrefuel_dz","kamazrepair","lada1","lada1_gdr","lada1_tk_civ_ep1","lada2","lada2_gdr","lada2_tk_civ_ep1","lada4_gdr","lada5_gdr","lada_base","ladalm","landrover_cz_ep1","landrover_mg_tk_ep1","landrover_mg_tk_ep1_dz","landrover_mg_tk_ep1_dze","landrover_mg_tk_ins_ep1","landrover_special_cz_ep1","landrover_special_cz_ep1_dz","landrover_special_cz_ep1_dze","landrover_spg9_tk_ep1","landrover_spg9_tk_ins_ep1","landrover_tk_civ_ep1","m1030","m1030_us_des_ep1","m1126_icv_m2_ep1","m1126_icv_mk19_ep1","m1128_mgs_ep1","m1129_mc_ep1","m1130_cv_ep1","m1133_mev_ep1","m1135_atgmv_ep1","m113_tk_ep1","m113_un_ep1","m113ambul_tk_ep1","m113ambul_tk_ep1_dz","m113ambul_un_ep1","m113ambul_un_ep1_dz","mmt_civ","mmt_usmc","mq9predatorb_us_ep1","mtvr","mtvr_des_ep1","mtvrreammo","mtvrreammo_des_ep1","mtvrrefuel","mtvrrefuel_des_ep1","mtvrrefuel_des_ep1_dz","mtvrrepair","mtvrrepair_des_ep1","mtvrsalvage_des_ep1","mtvrsupply_des_ep1","offroad_dshkm_gue","offroad_dshkm_gue_dz","offroad_dshkm_gue_dze","offroad_dshkm_gue_dze1","offroad_dshkm_gue_dze2","offroad_dshkm_gue_dze3","offroad_dshkm_gue_dze4","offroad_dshkm_ins","offroad_dshkm_tk_gue_ep1","offroad_spg9_gue","offroad_spg9_tk_gue_ep1","old_bike_tk_civ_ep1","old_bike_tk_ins_ep1","old_moto_tk_civ_ep1","papercar","pbx","pchela1t","pickup_pk_gue","pickup_pk_gue_dz","pickup_pk_gue_dze","pickup_pk_ins","pickup_pk_ins_dz","pickup_pk_ins_dze","pickup_pk_tk_gue_ep1","pickup_pk_tk_gue_ep1_dz","pickup_pk_tk_gue_ep1_dze","policecar","rhib","rhib2turret","s1203_ambulance_ep1","s1203_tk_civ_ep1","seafox","seafox_ep1","skoda","skodablue","skodagreen","skodared","smallboat_1","smallboat_2","suv_blue","suv_camo","suv_charcoal","suv_dz","suv_green","suv_orange","suv_pink","suv_pmc","suv_pmc_baf","suv_red","suv_silver","suv_tk_civ_ep1","suv_tk_ep1","suv_un_ep1","suv_white","suv_yellow","towingtractor","tractor","tractorold","uaz_ags30_cdf","uaz_ags30_ins","uaz_ags30_ru","uaz_ags30_tk_ep1","uaz_cdf","uaz_ins","uaz_mg_cdf","uaz_mg_cdf","uaz_mg_cdf_dz_lm","uaz_mg_cdf_dz_vlm","uaz_mg_ins","uaz_mg_ins_dz_lm","uaz_mg_ins_dz_vlm","uaz_mg_tk_ep1","uaz_mg_tk_ep1_dz","uaz_mg_tk_ep1_dze","uaz_ru","uaz_spg9_ins","uaz_unarmed_tk_civ_ep1","uaz_unarmed_tk_ep1","uaz_unarmed_un_ep1","ural_cdf","ural_ins","ural_tk_civ_ep1","ural_un_ep1","ural_zu23_cdf","ural_zu23_gue","ural_zu23_ins","ural_zu23_tk_ep1","ural_zu23_tk_gue_ep1","uralcivil","uralcivil2","uralopen_cdf","uralopen_ins","uralreammo_cdf","uralreammo_ins","uralreammo_tk_ep1","uralrefuel_cdf","uralrefuel_ins","uralrefuel_tk_ep1","uralrefuel_tk_ep1_dz","uralrepair_cdf","uralrepair_ins","uralrepair_tk_ep1","uralsalvage_tk_ep1","uralsupply_tk_ep1","v3s_civ","v3s_gue","v3s_open_tk_civ_ep1","v3s_open_tk_ep1","v3s_reammo_tk_gue_ep1","v3s_refuel_tk_gue_ep1","v3s_refuel_tk_gue_ep1_dz","v3s_repair_tk_gue_ep1","v3s_salvage_tk_gue_ep1","v3s_supply_tk_gue_ep1","v3s_tk_ep1","v3s_tk_gue_ep1","volha_1_tk_civ_ep1","volha_2_tk_civ_ep1","volhalimo_tk_civ_ep1","vwgolf","zodiac","zsu_cdf","zsu_ins",	"zsu_tk_ep1"];
dayz_zombieTargetList	= [["SoldierWB",50],["Air",500],["LandVehicle",200]];

PVDZE_plr_Hit			= [];
PVDZE_obj_Publish		= [];
PVDZE_InTransit			= [];
PVDZE_plr_HideBody		= objNull;
dayz_selectedVault		= objNull;
dayz_selectedDoor		= objNull;

PVDZE_veh_Publish		= [];
PVDZE_obj_Trade			= [];
PVDZE_plr_TradeMenu		= [];
PVDZE_plr_DeathB		= [];

//DayZ settings
dayz_dawn				= 6;
dayz_dusk				= 18;
DAYZ_agentnumber		= 0;
dayz_animalDistance		= 800;
dayz_zSpawnDistance		= 1000;

dayz_maxMaxModels		= 60;
dayz_spawnArea			= 400;
dayz_cantseeDist		= 150;
dayz_cantseefov			= 70;
dayz_canDelete			= 300;

if(isNil "DZE_SelfTransfuse")				then { DZE_SelfTransfuse = false; };
if(isNil "dayz_maxAnimals")					then { dayz_maxAnimals = 5; };
if(isNil "timezoneswitch")					then { timezoneswitch = 0; };
if(isNil "dayz_maxLocalZombies")			then { dayz_maxLocalZombies = 15; };
if(isNil "dayz_maxGlobalZombiesInit")		then { dayz_maxGlobalZombiesInit = 15; };
if(isNil "dayz_maxGlobalZombiesIncrease")	then { dayz_maxGlobalZombiesIncrease = 5; };
if(isNil "dayz_maxZeds")					then { dayz_maxZeds = 500; };
if(isNil "DZE_PlayerZed")					then { DZE_PlayerZed = true; };
if(isNil "DZE_GodModeBase")					then { DZE_GodModeBase = false; };
if(isNil "DZEdebug")						then { DZEdebug = false; };
if(isNil "DZE_Debug_Damage")				then { DZE_Debug_Damage = true; };
if(isNil "DZE_TRADER_SPAWNMODE")			then { DZE_TRADER_SPAWNMODE = false; };
if(isNil "dayz_tameDogs")					then { dayz_tameDogs = false; };
if(isNil "dayz_sellDistance_vehicle")		then { dayz_sellDistance_vehicle = 10; };
if(isNil "dayz_sellDistance_boat")			then { dayz_sellDistance_boat = 30; };
if(isNil "dayz_sellDistance_air")			then { dayz_sellDistance_air = 40; };
if(isNil "dayz_paraSpawn")					then { dayz_paraSpawn = false; };
if(isNil "dayz_minpos")						then { dayz_minpos = -20000; };
if(isNil "dayz_maxpos")						then { dayz_maxpos = 20000; };
if(isNil "DZE_BuildingLimit")				then { DZE_BuildingLimit = 150; };
if(isNil "DZE_HumanityTargetDistance")		then { DZE_HumanityTargetDistance = 25; };
if(isNil "DZE_FriendlySaving")				then { DZE_FriendlySaving = true; };
if(isNil "DZE_BuildOnRoads")				then { DZE_BuildOnRoads = false; };
if(isNil "DZE_MissionLootTable")			then { DZE_MissionLootTable = false; };
if(isNil "DZE_ConfigTrader")				then { DZE_ConfigTrader = false; };
if(isNil "DZE_LootSpawnTimer")				then { DZE_LootSpawnTimer = 10; };
if(isNil "DZE_HeliLift")					then { DZE_HeliLift = true; };
if(isNil "DZE_DamageBeforeMaint")			then { DZE_DamageBeforeMaint = 0.09; };
if(isNil "DZE_StaticConstructionCount")		then { DZE_StaticConstructionCount = 0; };
if(isNil "DZE_selfTransfuse_Values")		then { DZE_selfTransfuse_Values = [12000,15,300]; };
if(isNil "helperDetach")					then { helperDetach = false; };
if(isNil "DZE_modularBuild")				then { DZE_modularBuild = false; };
if(isNil "DZE_snapExtraRange")				then { DZE_snapExtraRange = 0; };
if(isNil "DZE_APlotforLife")				then { DZE_APlotforLife = false; };
if(isNil "DZE_PlotOwnership")				then { DZE_PlotOwnership = false; };
if(isNil "DZE_checkNearbyRadius")			then { DZE_checkNearbyRadius = 30; };
if(isNil "DZE_PlotPole")					then { DZE_PlotPole = [30,45]; };
if(isNil "DZE_maintainRange")				then { DZE_maintainRange = ((DZE_PlotPole select 0)+30); };
if(isNil "dayz_zedSpawnVehCount")			then { dayz_zedSpawnVehCount = dayz_maxLocalZombies / 2; };
if(isNil "dayz_spawnAirCount")				then { dayz_spawnAirCount = 0; };
if(isNil "dayz_zedsAttackVehicles")			then { dayz_zedsAttackVehicles = true; };

DZE_snap_build_file		= "";
DZE_REPLACE_WEAPONS		= [["Crossbow","ItemMatchbox","ItemHatchet"],["Crossbow_DZ","ItemMatchbox_DZE","ItemHatchet_DZE"]];
dayz_updateObjects		= ["Plane","Tank","Car","Helicopter","Motorcycle","Ship","TentStorage","VaultStorage","LockboxStorage","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","GunRack_DZ","WoodCrate_DZ","Scaffolding_DZ"];
dayz_disallowedVault	= ["TentStorage","BuiltItems","ModularItems","DZE_Base_Object"];
dayz_reveal				= ["AllVehicles","WeaponHolder","Land_A_tent","BuiltItems","ModularItems","DZE_Base_Object","AllUnits"];
dayz_allowedObjects		= ["TentStorage","TentStorageDomed","TentStorageDomed2","VaultStorageLocked","Hedgehog_DZ","Sandbag1_DZ","BagFenceRound_DZ","TrapBear","Fort_RazorWire","WoodGate_DZ","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Land_HBarrier5_DZ","Fence_corrugated_DZ","M240Nest_DZ","CanvasHut_DZ","ParkBench_DZ","MetalGate_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","Plastic_Pole_EP1_DZ","Generator_DZ","StickFence_DZ","LightPole_DZ","FuelPump_DZ","DesertCamoNet_DZ","ForestCamoNet_DZ","DesertLargeCamoNet_DZ","ForestLargeCamoNet_DZ","SandNest_DZ","DeerStand_DZ","MetalPanel_DZ","WorkBench_DZ","WoodFloor_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","LockboxStorageLocked","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodStairs_DZ","WoodStairsSans_DZ","WoodStairsRails_DZ","WoodSmallWallThird_DZ","WoodLadder_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallSmallDoorway_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","MetalFloor_DZ","WoodRamp_DZ","GunRack_DZ","FireBarrel_DZ","WoodCrate_DZ","Scaffolding_DZ"];
DZE_LockableStorage		= ["VaultStorage","VaultStorageLocked","LockboxStorageLocked","LockboxStorage"];
DZE_LockedStorage		= ["VaultStorageLocked","LockboxStorageLocked"];
DZE_UnLockedStorage		= ["VaultStorage","LockboxStorage"];
DZE_maintainClasses		= ["MetalFloor_DZ","WoodRamp_DZ","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","CinderWallSmallDoorway_DZ","WoodFloor_DZ","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodLargeWall_DZ","WoodLargeWallDoor_DZ","WoodLargeWallWin_DZ","WoodSmallWall_DZ","WoodSmallWallThird_DZ","WoodSmallWallWin_DZ","WoodSmallWallDoor_DZ","WoodStairs_DZ","WoodLadder_DZ","WoodStairsRails_DZ","WoodStairsSans_DZ","DZE_Housebase","LightPole_DZ","BuiltItems","Plastic_Pole_EP1_DZ","Fence_corrugated_DZ","CanvasHut_DZ","ParkBench_DZ","MetalGate_DZ","StickFence_DZ","DesertCamoNet_DZ","ForestCamoNet_DZ","DesertLargeCamoNet_DZ","ForestLargeCamoNet_DZ","DeerStand_DZ","Scaffolding_DZ","FireBarrel_DZ","TentStorage","TentStorageDomed","TentStorageDomed2","Hedgehog_DZ","Sandbag1_DZ","BagFenceRound_DZ","Fort_RazorWire","WoodGate_DZ","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Land_HBarrier5_DZ","M240Nest_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","Generator_DZ","FuelPump_DZ","SandNest_DZ","MetalPanel_DZ","WorkBench_DZ","Land_DZE_GarageWoodDoor","Land_DZE_LargeWoodDoor","Land_DZE_WoodDoor","Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallDoor_DZ","CinderWallDoorLocked_DZ","CinderWallDoorSmall_DZ","CinderWallDoorSmallLocked_DZ","GunRack_DZ","WoodCrate_DZ"];
DZE_DoorsLocked			= ["Land_DZE_GarageWoodDoorLocked","Land_DZE_LargeWoodDoorLocked","Land_DZE_WoodDoorLocked","CinderWallDoorLocked_DZ","CinderWallDoorSmallLocked_DZ"];
DZE_isRemovable			= ["Fence_corrugated_DZ","M240Nest_DZ","ParkBench_DZ","FireBarrel_DZ","Scaffolding_DZ","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","GunRack_DZ","WoodCrate_DZ"];
DZE_isWreck				= ["SKODAWreck","HMMWVWreck","UralWreck","datsun01Wreck","hiluxWreck","datsun02Wreck","UAZWreck","Land_Misc_Garb_Heap_EP1","Fort_Barricade_EP1","Rubbish2"];
DZE_isWreckBuilding		= ["Land_wreck_cinder","Land_wood_wreck_quarter","Land_wood_wreck_floor","Land_wood_wreck_third","Land_wood_wreck_frame","Land_iron_vein_wreck","Land_silver_vein_wreck","Land_gold_vein_wreck","Land_ammo_supply_wreck"];
DZE_isNewStorage		= ["VaultStorage","OutHouse_DZ","Wooden_shed_DZ","WoodShack_DZ","StorageShed_DZ","GunRack_DZ","WoodCrate_DZ"];
dayz_fuelpumparray		= ["FuelPump_DZ","Land_A_FuelStation_Feed","Land_Ind_FuelStation_Feed_EP1","Land_FuelStation_Feed_PMC","FuelStation","Land_ibr_FuelStation_Feed","Land_fuelstation_army","Land_fuelstation","land_fuelstation_w","Land_benzina_schnell"];
DZE_fueltruckarray		= ["KamazRefuel_DZ","UralRefuel_TK_EP1_DZ","MtvrRefuel_DES_EP1_DZ","V3S_Refuel_TK_GUE_EP1_DZ","MtvrRefuel_DZ","KamazRefuel_DZE","UralRefuel_TK_EP1_DZE","MtvrRefuel_DES_EP1_DZE","V3S_Refuel_TK_GUE_EP1_DZE","MtvrRefuel_DZE"];
dayz_fuelsources		= ["Land_Ind_TankSmall","Land_fuel_tank_big","Land_fuel_tank_stairs","Land_fuel_tank_stairs_ep1","Land_wagon_tanker","Land_fuelstation","Land_fuelstation_army","land_fuelstation_w","Land_benzina_schnell"];
DZE_Lock_Door			= "";

if(isNil "DZE_plotOwnershipExclusions") then { DZE_plotTakeOwnershipItems = dayz_allowedObjects - (DZE_LockableStorage + ["Plastic_Pole_EP1_DZ","TentStorage","TentStorageDomed","TentStorageDomed2"]); };

call compile preprocessFileLineNumbers "\z\addons\dayz_code\init\loot_init.sqf";

if(isServer) then { 
	dayz_players 			= [];
	dead_bodyCleanup		= [];
	needUpdate_objects		= [];
	hasSpawnedBike			= [];

	DZE_delChk 				= 0;
	DZE_DYN_AntiStuck		= 0;
	DZE_DYN_AntiStuck2nd	= 0;
	DZE_DYN_AntiStuck3rd	= 0;

	if(isNil "dayz_fullMoonNights")		then { dayz_fullMoonNights = false; };
	if(isNil "EpochEvents")				then { EpochEvents = []; };
	if(isNil "DZE_vehicleAmmo")			then { DZE_vehicleAmmo = 0; };
	if(isNil "DZE_BackpackGuard")		then { DZE_BackpackGuard = true; };
	if(isNil "DZE_CleanNull")			then { DZE_CleanNull = false; };
	if(isNil "DZE_DeathMsgGlobal")		then { DZE_DeathMsgGlobal = false; };
	if(isNil "DZE_DeathMsgSide")		then { DZE_DeathMsgSide = false; };
	if(isNil "DZE_DeathMsgTitleText")	then { DZE_DeathMsgTitleText = false; };
	if(isnil "MaxVehicleLimit")			then { MaxVehicleLimit = 50; };
	if(isnil "MaxAmmoBoxes")			then { MaxAmmoBoxes = 10; };

	DZE_safeVehicle	= ["ParachuteWest","ParachuteC"];

	immune_objects = ["WoodStairsRails_DZ","BagFenceRound_DZ","FireBarrel_DZ","Hedgehog_DZ","LightPole_DZ","WoodLargeWallWin_DZ","StickFence_DZ","WorkBench_DZ","Fort_RazorWire","Sandbag1_DZ","WoodFloor_DZ","WoodFloorHalf_DZ","WoodFloorQuarter_DZ","WoodLargeWallWin_DZ","WoodLargeWall_DZ","WoodSmallWallDoor_DZ","WoodSmallWallWin_DZ","Land_DZE_WoodDoor","Land_DZE_LargeWoodDoor","WoodLadder_DZ","WoodStairsSans_DZ","WoodStairs_DZ","WoodSmallWall_DZ","WoodSmallWallThird_DZ","CinderWallHalf_DZ","CinderWall_DZ","CinderWallDoorway_DZ","MetalFloor_DZ","Land_HBarrier1_DZ","Land_HBarrier3_DZ","Land_HBarrier5_DZ","FuelPump_DZ","WoodRamp_DZ"];
};

if(!isDedicated) then {
	dayz_spawnPos				= getPosATL player;
	epochObjectsLoaded			= false;
	missionObjectsLoaded		= false;

	spawned						= [];
	already_removed				= [];

	dayz_buildingMonitor		= [];
	dayz_bodyMonitor			= [];

	zeroPreviousWeather			= [0,0,[0,0],0];
	zeroCurrentWeather			= [0,0,[0,0],0];

	if(DZE_MissionLootTable) then { 
		dayz_baseTypes 			= getArray (missionConfigFile >> "CfgBuildingLoot" >> "Default" >> "zombieClass");
	} else {
		dayz_baseTypes			= getArray (configFile >> "CfgBuildingLoot" >> "Default" >> "zombieClass");
	};

	foodVal_CHK					= -1;
	thirstVal_CHK				= -1;
	combatVal_CHK				= -1;
	bloodVal_CHK				= -1;
	humanity_CHK				= -1;
	money_CHK					= -1;
	restart_CHK					= -1;

	dayz_temperatur 			= 36;
	dayz_temperaturnormal 		= 36;
	dayz_temperaturmax 			= 42;
	dayz_temperaturmin 			= 27;
	dayZ_lastPlayerUpdate		= 0;
	dayZ_everyonesTents			= [];
	dayz_hunger					= 0;
	dayz_thirst					= 0;
	dayz_combat					= 0;
	dayz_preloadFinished		= false;
	dayz_statusArray			= [1,1];
	dayz_disAudial				= 0;
	dayz_disVisual				= 0;
	dayz_firedCooldown			= 0;
	dayz_DeathActioned			= false;
	dayz_canDisconnect			= true;
	dayz_damageCounter			= time;
	dayz_lastSave				= time;
	dayz_isSwimming				= true;
	dayz_isKneeling				= false;
	dayz_isCrawling				= false;
	dayz_PreviousTown			= "Wilderness";
	dayz_currentDay				= 0;
	dayz_hasLight				= false;
	dayz_surfaceNoise			= 0;
	dayz_surfaceType			= "None";
	dayz_noPenalty				= [];
	dayz_heavenCooldown			= 0;
	deathHandled				= false;
	dayz_lastHumanity			= 0;
	dayz_guiHumanity			= -90000;
	dayz_firstGroup				= group player;
	dayz_originalPlayer			= player;
	dayz_sourceBleeding			= objNull;
	dayz_clientPreload			= false;
	dayz_authed					= false;
	dayz_panicCooldown			= 0;
	dayz_areaAffect				= 2.5;
	dayz_heartBeat				= false;
	dayzClickTime				= 0;
	dayz_spawnZombies			= 0;
	dayz_swarmSpawnZombies		= 3;
	dayz_maxLocalZombies		= 6;
	dayz_CurrentNearByZombies	= 0;
	dayz_maxNearByZombies		= 9;
	dayz_currentGlobalZombies	= 0;
	dayz_maxGlobalZeds			= 350;
	dayz_spawnDelay				= 150;
	dayz_spawnWait				= -150;
	dayz_lootDelay				= 5;
	dayz_lootWait				= -150;
	dayz_CurrentZombies			= 0;
	dayz_tickTimeOffset			= 0;
	dayz_currentWeaponHolders	= 0;
	dayz_maxMaxWeaponHolders	= 80;
	dayz_maxCurrentZeds			= 0;
	dayz_inVehicle				= false;
	dayz_Magazines				= [];
	dayzGearSave				= false;
	dayz_unsaved				= false;
	dayz_scaleLight				= 0;
	dayz_myLiftVehicle			= objNull;
	dayzDebug					= false;
	dayzState					= -1;

	if(isNil "DZE_AllowForceSave")			then { DZE_AllowForceSave = false; };
	if(isNil "DZE_AllowCargoCheck")			then { DZE_AllowCargoCheck = true; };
	if(isNil "DZE_ForceNameTags")			then { DZE_ForceNameTags = false; };
	if(isNil "DZE_ForceNameTagsOff")		then { DZE_ForceNameTagsOff = false; };
	if(isNil "DZE_ForceNameTagsInTrader")	then { DZE_ForceNameTagsInTrader = false; };
	if(isNil "DZE_HaloJump")				then { DZE_HaloJump = true; };
	if(isNil "DZE_AntiWallLimit")			then { DZE_AntiWallLimit = 3; };
	if(isNil "DZE_requireplot")				then { DZE_requireplot = 1; };
	if(isNil "DZE_R3F_WEIGHT")				then { DZE_R3F_WEIGHT = true; };
	if(isNil "deleteObjects")				then { deleteObjects = []; };

	DZE_ActionInProgress 	= false;
	DZE_AntiWallCounter		= 0;
	DZE_FreshSpawn			= false;
	DZE_myHaloVehicle		= objNull;
	DZE_Friends				= [];
	DZE_CanPickup			= true;
	DZE_Q					= false;
	DZE_Z					= false;
	DZE_Q_alt				= false;
	DZE_Z_alt				= false;
	DZE_Q_ctrl				= false;
	DZE_Z_ctrl				= false;
	DZE_5					= false;
	DZE_4					= false;
	DZE_6					= false;
	DZE_F					= false;
	DZE_cancelBuilding		= false;
	DZE_PZATTACK			= false;
	DZE_trees				= ["t_picea2s_snow.p3d","b_corylus.p3d","t_quercus3s.p3d","t_larix3s.p3d","t_pyrus2s.p3d","str_briza_kriva.p3d","dd_borovice.p3d","les_singlestrom_b.p3d","les_singlestrom.p3d","smrk_velky.p3d","smrk_siroky.p3d","smrk_maly.p3d","les_buk.p3d","str krovisko vysoke.p3d","str_fikovnik_ker.p3d","str_fikovnik.p3d","str vrba.p3d","hrusen2.p3d","str dub jiny.p3d","str lipa.p3d","str briza.p3d","p_akat02s.p3d","jablon.p3d","p_buk.p3d","str_topol.p3d","str_topol2.p3d","p_osika.p3d","t_picea3f.p3d","t_picea2s.p3d","t_picea1s.p3d","t_fagus2w.p3d","t_fagus2s.p3d","t_fagus2f.p3d","t_betula1f.p3d","t_betula2f.p3d","t_betula2s.p3d","t_betula2w.p3d","t_alnus2s.p3d","t_acer2s.p3d","t_populus3s.p3d","t_quercus2f.p3d","t_sorbus2s.p3d","t_malus1s.p3d","t_salix2s.p3d","t_picea1s_w.p3d","t_picea2s_w.p3d","t_ficusb2s_ep1.p3d","t_populusb2s_ep1.p3d","t_populusf2s_ep1.p3d","t_amygdalusc2s_ep1.p3d","t_pistacial2s_ep1.p3d","t_pinuse2s_ep1.p3d","t_pinuss3s_ep1.p3d","t_prunuss2s_ep1.p3d","t_pinusn2s.p3d","t_pinusn1s.p3d","t_pinuss2f.p3d","t_poplar2f_dead_pmc.p3d","misc_torzotree_pmc.p3d","misc_burnspruce_pmc.p3d","brg_cocunutpalm8.p3d","brg_umbrella_acacia01b.p3d","brg_jungle_tree_canopy_1.p3d","brg_jungle_tree_canopy_2.p3d","brg_cocunutpalm4.p3d","brg_cocunutpalm3.p3d","palm_01.p3d","palm_02.p3d","palm_03.p3d","palm_04.p3d","palm_09.p3d","palm_10.p3d","brg_cocunutpalm2.p3d","brg_jungle_tree_antiaris.p3d","brg_cocunutpalm1.p3d","str habr.p3d"];
	DZE_TEMP_treedmg		= 1;
	DZE_Surrender			= false;
	DZE_Quarantine			= false;
	DZE_InRadiationZone		= false;
	DZE_SaveTime			= 30;

	inSafezone				= false;
};