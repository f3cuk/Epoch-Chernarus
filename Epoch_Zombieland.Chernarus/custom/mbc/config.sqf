private["_junk_group","_food_group","_military_group","_medical_group","_vehicle_repair_group","_common_group","_assault_group","_lmg_group","_sniper_group","_tools_group","_chainbullets_group","_rares_group","_rare_weapons_group","_legend_group","_chainsaw_group"];

MBT_NAME = "EpochPacks"; //Name of the item that spawns the reward (this is just a visual thing,code won't break if you change this to something random)
MBT_CRATEDELAY = 900; //How long until the reward crate disappears (in seconds) Default: 900 (15 minutes)
MBT_DIALOG_TITLE = "EpochPack opening"; //Reward dialog title
MBT_DIALOG_CLAIM = "Claim Your Reward"; //Claim reward button
MBT_DIALOG_NOTE = "* After claiming your prize the reward crate will disappear in 15 minutes."; //Notation warning about the crate's delay

/*
		REWARD CONFIGURATION
		Everything that has to do with the prize you get from the briefcase
*/

// Junk
_junk_group = ["HandRoadFlare","TrashTinCan","FoodCanUnlabeled","HandChemBlue","HandChemRed","HandChemGreen","ItemBook3","ItemBook4","ItemSodaR4z0rEmpty","ItemSodaDrwasteEmpty","ItemSodaLemonadeEmpty","ItemSodaLvgEmpty","ItemSodaMzlyEmpty","ItemSodaRabbitEmpty","ItemSodaClaysEmpty","TrashJackDaniels","TrashTinCan","ItemLetter","ItemBook1","ItemBook2","ItemTrashRazor","FoodCanOrlokEmpty","FoodCanDemonEmpty","FoodCanTylersEmpty","FoodCanCornEmpty","FoodCanBoneboyEmpty","FoodCanBadguyEmpty","FoodCanGriffEmpty","FoodCanPowellEmpty","FoodCanHerpyEmpty","FoodCanUnlabeledEmpty","FoodCanCurgonEmpty","FoodCanFraggleosEmpty","ItemTrashToiletpaper"];

// Common
_food_group = ["ItemWaterbottle","FoodNutmix","FoodPistachio","FoodMRE","ItemSodaOrangeSherbet","ItemSodaRbull","ItemSodaR4z0r","ItemSodaMdew","ItemSodaPepsi","ItemSodaCoke","FoodbaconCooked","FoodCanBakedBeans","FoodCanFrankBeans","FoodCanPasta","FoodCanSardines","FoodchickenCooked","FoodmuttonCooked","FoodrabbitCooked","ItemTroutCooked","ItemTunaCooked","ItemSeaBassCooked","FoodCanGriff","FoodCanTylers","FoodCanDemon","FoodCanPowell","FoodCanCorn","FoodCanOrlok","FoodCanHerpy","FoodCanBadguy","FoodCanBoneboy","FoodCanCurgon","FoodCanFraggleos","ItemSodaRabbit","ItemSodaMtngreenEmpty","ItemSodaSmashtEmpty","ItemSodaMtngreen","ItemSodaDrwaste","ItemSodaSmasht","ItemSodaClays","ItemSodaLemonade","ItemSodaLvg"];
_military_group = ["FlareWhite_M203","FlareGreen_M203","1Rnd_Smoke_M203","HandGrenade_west","HandGrenade_east","SmokeShell","SmokeShellRed","SmokeShellGreen","FoodMRE","Skin_Camo1_DZ","Skin_Rocket_DZ","Skin_Soldier1_DZ","Skin_Drake_Light_DZ"];
_medical_group = ["ItemAntibiotic","ItemBloodbag","ItemEpinephrine","ItemHeatPack","ItemMorphine","ItemBandage","FoodCanFrankBeans","FoodCanPasta"];
_vehicle_repair_group = ["PartEngine","PartFueltank","PartGeneric","PartGlass","PartVRotor","PartWheel"];

_common_group = ["ItemPlotDeed","ItemComboLock","ItemSledgeHead","ItemSledgeHandle","Skin_Sniper1_DZ","bulk_ItemSandbag"];
_assault_group = ["M16A4_ACG","Sa58V_RCO_EP1","SCAR_L_STD_Mk4CQT","M8_sharpshooter","M4A1_HWS_GL_camo","SCAR_L_STD_HOLO","M4A3_CCO_EP1","M4A1_AIM_SD_camo","M16A4","m8_carbine","BAF_L85A2_RIS_Holo","Sa58P_EP1","Sa58V_CCO_EP1","Sa58V_EP1","AKS_74_kobra","AKS_74_U","AKS_GOLD","AK_47_M","AK_74","FN_FAL","FN_FAL_ANPVS4","m8_compact","G36A_camo","G36C","m8_holo_sd","G36C_camo","G36K_camo","G36_C_SD_camo","M16A2","M16A2GL","M4A1","M4A1_Aim"];
_lmg_group = ["RPK_74","M249_EP1_DZ","M249_DZ","M240_DZ","m240_scoped_EP1_DZE","M249_m145_EP1_DZE","M60A4_EP1_DZE"];
_sniper_group = ["M14_EP1","SVD_CAMO","SVD","VSS_Vintorez","DMR_DZ","M40A3","M24","M24_des_EP1","SVD_des_EP1"];
_tools_group = ["ItemKeyKit","Binocular","Binocular_Vector","ItemCompass","ItemCrowbar","ItemEtool","ItemFishingPole","ItemFlashlightRed","ItemGPS","ItemHatchet_DZE","ItemKnife","ItemMachete","ItemMatchbox_DZE","ItemToolbox","NVGoggles"];
_chainbullets_group	= ["2000Rnd_762x51_M134","200Rnd_762x51_M240","100Rnd_127x99_M2","150Rnd_127x107_DSHKM"];

// Rares
_rares_group = ["ItemVault","ItemBriefcase100oz","ItemLockbox","30m_plot_kit"];
_rare_weapons_group = ["KSVK_DZE","MK_48_DZ","Pecheneg_DZ","M110_NVG_EP1","SCAR_H_LNG_Sniper_SD","M107_DZ","BAF_LRR_scoped"];

// Legendaries
_legend_group = ["PipeBomb","ItemHotwireKit"];
_chainsaw_group = ["Chainsaw","ChainsawB","ChainsawG","ChainsawP","BAF_AS50_scoped"];

MBC_REWARDLIST = [
	//Reward List format:
	//[type,item,quantity,raritylevel,rarity]
	//		type - item type. Available options: 
	//			magazine - any type of magazine and most general items (briefcases,cinder blocks,ammunition,etc)
	//			weapon - any type of weapon,note that toolbelt items are also considered weapons in Arma
	//			group_mag - a group of magazines. This is an array of items from which only 1 will be randomly picked
	//			group_wep - a group of weapons. An array of weapons from which only 1 will be randomly picked
	//			group_tool - a group of tools. An array of tools from which only 1 will be randomly picked
	//			coins - this is for Zupa's Single Currency script only. Only use it if you have that script. If you don't do not use coins as a type for reward
	//			script - this is an experimental feature for more advanced users. I haven't tested it thoroughly so use it at your own risk.
	//				It was meant to work as a power-up rather than having an item as a reward. If you use "script" as a type,you must type the script's full path to the "item" field
	//		item - class name of item. If type is group,insert the group's variable. Example: 30m_plot_pole,ItemHotwireKit,_sniper_group,_junk_group
	//		quantity - number of items,set it to 1 if you're using grouping. Example: 15 (in case item is ItemHotwireKit then it will give you 15 Hotwire Kits)
	//		raritylevel - the level of rarity from 1 to 4 (1 = least rare,4 = rarest),this is just visual for the UI
	//		rarity - how likely this item will be picked in percentage (from 0 to 100)
	//			Note: total sum of rarity must equal 100

	// Bad luck (junk items with low possibility)
	 ["group_mag",_junk_group,1,1,4]
	 
	// Common 
	,["group_wep",_assault_group,1,2,6]
	,["group_wep",_lmg_group,1,2,6]
	,["group_wep",_sniper_group,1,2,6]
	,["group_mag",_military_group,1,2,4]
	,["group_mag",_medical_group,5,2,4]
	,["group_mag",_vehicle_repair_group,2,2,4]
	,["group_mag",_common_group,1,2,6]
	,["group_mag",_chainbullets_group,5,2,4]
	,["group_tool",_tools_group,1,2,6]
	,["coins","Coins",2500,2,5]
	,["coins","Coins",3000,2,4]
	,["coins","Coins",5000,2,3]
	,["magazine","ItemGoldBar10oz",3,2,3]
	,["magazine","PartPlywoodPack",15,2,3]
	,["magazine","PartPlankPack",15,2,3]

	// Rare
	,["group_wep",_rare_weapons_group,1,3,5]
	,["group_mag",_rares_group,1,3,5]
	,["magazine","ItemGoldBar10oz",6,3,2]
	,["coins","Coins",10000,3,2]
	,["magazine","CinderBlocks",15,3,2]
	,["magazine","ItemSilvercase_Base",1,3,2]
	,["magazine","PartPlywoodPack",30,3,2]
	,["magazine","PartPlankPack",30,3,2]
	,["magazine","ItemPole",30,3,2]

	// Legendary
	,["group_wep",_chainsaw_group,1,4,1]
	,["group_mag",_legend_group,1,4,1]
	,["magazine","ItemBriefcase_Base",1,4,1]
	,["coins","Coins",20000,4,1]
	,["coins","Coins",50000,4,1]
];