class GivePlayerDialog
{
	idd = -1;
	movingenable = 0;
	enableSimulation = true;
	
	class controlsBackground {
		class Life_RscTitleBackground2:Life_RscText {
			colorBackground[] = {0.835,0.627,0.251,1};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};
		
		class MainBackground2:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.6 - (22 / 250);
		};
	};
	
	class Controls {
		
		class RscTextT_10052 : RscTextT
		{
			idc = 14001;
			text = "";
			colorText[] = {1,1,1,1};
			x = 0.39;
			y = 0.27;
			w = 0.6;
			h = 0.2;
		};
		
		class moneyEdit2 : Life_RscEdit {
		
			idc = 14000;
			colorText[] = {0.8784,0.8471,0.651,1};
			text = ""; 
			sizeEx = 0.030;
			x = 0.4; 
			y = 0.41;
			w = 0.2; 
			h = 0.03;
		
		};
		
		class Title2 : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Transfer Coins";
			colorText[] = {1,1,1,1};
			shadow = 0;
			x = 0.35;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class DepositButton2 : life_RscButtonMenu 
		{
			idc = -1;
			text = "Give";
			colorBackground[] = {0.835,0.627,0.251,1};
			onButtonClick = "[(ctrlText 14000)] spawn GivePlayerAmount; ((ctrlParent (_this select 0)) closeDisplay 9000);";
			colorText[] = {0.8784,0.8471,0.651,1};
			x = 0.432;
			y = 0.512;
			w = (6 / 40);
			h = (1 / 25);
		};
		
		class RscTextT_10005 : RscTextT
		{
			idc = 14003;
			text = "";
			colorText[] = {0.8784,0.8471,0.651,1};
			x = 0.39;
			y = 0.58;
			w = 0.3;
			h = 0.2;
		};
		
		class CloseButtonKey2 : Life_RscButtonMenu {
			idc = -1;
			text = "Close";
			onButtonClick = "((ctrlParent (_this select 0)) closeDisplay 9000);";
			x = 0.35;
			y = 0.8 - (1 / 25);
			w = (6.25 / 40);
			h = (1 / 25);
		};
	};
};