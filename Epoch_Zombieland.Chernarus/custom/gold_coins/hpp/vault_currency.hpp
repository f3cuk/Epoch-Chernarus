class VaultDialog
{
	idd = -1;
	movingenable = 0;
	enableSimulation = true;
	
	class controlsBackground {
		class Life_RscTitleBackground:Life_RscText {
			colorBackground[] = {0.835,0.627,0.251,1};
			idc = -1;
			x = 0.35;
			y = 0.2;
			w = 0.3;
			h = (1 / 25);
		};
		
		class MainBackground:Life_RscText {
			colorBackground[] = {0, 0, 0, 0.7};
			idc = -1;
			x = 0.35;
			y = 0.2 + (11 / 250);
			w = 0.3;
			h = 0.6 - (22 / 250);
		};
	};
	
	class Controls {

		class CashTitle : Life_RscStructuredText
		{
			idc = 2701;
			text = "Coins inside";
			colorText[] = {0.8784,0.8471,0.651,1};
			shadow = 0;
			x = 0.39;
			y = 0.26;
			w = 0.3;
			h = 0.2;
		};
		
		class RscTextT_1005 : RscTextT
		{
			idc = 13002;
			text = "";
			colorText[] = {1,1,1,1};
			x = 0.39;
			y = 0.27;
			w = 0.6;
			h = 0.2;
		};
		
		class moneyEdit : Life_RscEdit {
		
		idc = 2702;
		colorText[] = {0.8784,0.8471,0.651,1};
		text = "";
		sizeEx = 0.030;
		x = 0.4;
		y = 0.41;
		w = 0.2;
		h = 0.03;
		
		};
		
		class Title : Life_RscTitle {
			colorBackground[] = {0, 0, 0, 0};
			idc = -1;
			text = "Vault";
			shadow = 0;
			colorText[] = {1,1,1,1};
			x = 0.35;
			y = 0.2;
			w = 0.6;
			h = (1 / 25);
		};
		
		class WithdrawButton : life_RscButtonMenu 
		{
			idc = -1;
			text = "Withdraw";
			colorBackground[] = {0.835,0.627,0.251,1};
			onButtonClick = "[(ctrlText 2702)] spawn VaultWithdrawAmount; ((ctrlParent (_this select 0)) closeDisplay 9000);";
			colorText[] = {0.8784,0.8471,0.651,1};
			x = 0.432;
			y = 0.46;
			w = (6 / 40);
			h = (1 / 25);
		};
		
		class DepositButton : life_RscButtonMenu 
		{
			idc = -1;
			text = "Deposit";
			colorBackground[] = {0.835,0.627,0.251,1};
			onButtonClick =  "[(ctrlText 2702)] spawn VaultDepositAmount; ((ctrlParent (_this select 0)) closeDisplay 9000);";
			colorText[] = {0.8784,0.8471,0.651,1};
			x = 0.432;
			y = 0.512;
			w = (6 / 40);
			h = (1 / 25);
		};
		
		class RscTextT_1004 : RscTextT
		{
			idc = 13001;
			text = "";
			colorText[] = {1,1,1,1};
			x = 0.39;
			y = 0.59;
			w = 0.6;
			h = 0.2;
		};
		
		class CloseButtonKey : Life_RscButtonMenu {
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