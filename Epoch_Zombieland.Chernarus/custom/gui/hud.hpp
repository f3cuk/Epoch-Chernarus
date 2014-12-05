#define CT_STATIC		0
#define ST_LEFT			0x00
#define ST_PICTURE		48

class RscStructuredText {
	access = ReadAndWrite;
	type = 13;
	idc = -1;
	style = 2; 
	font = "Bitstream";
	size = "0.03921";
	colorText[] = {1,1,1,1};
	colorBackground[] = {0,0,0,0};
	text = "";
	shadow = 2;
	class Attributes {
		align = "center";
		valign = "middle";	
	};
};

class RscTitles 
{

	class playerStatusGUI {

		idd = 6900;
		movingEnable = 0;
		duration = 100000;
		name = "statusBorder";
		onLoad = "uiNamespace setVariable['DAYZ_GUI_display',_this select 0];";

		class ControlsBackground {
			class RscStructuredText_1199 : RscStructuredText {
				idc = 1199;
				x = 0.25;
				y = 0.35;
				w = 0.5;
				h = 0.1;
			};
			class RscPicture_81200: RscPictureGUI {
				idc = 81200;
				text = "custom\gui\icons\restart.paa";
				x = safeZoneX + safeZoneW - 0.175;
				y = safeZoneY + safeZoneH - 0.17;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
			};
			class RscPicture_81201: RscPictureGUI {
				idc = 81201;
				text = "custom\gui\icons\humanity.paa";
				x = safeZoneX + safeZoneW - 0.250;
				y = safeZoneY + safeZoneH - 0.17;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
			};
			class RscPicture_81202: RscPictureGUI {
				idc = 81202;
				text = "custom\gui\icons\money.paa";
				x = safeZoneX + 0.320;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.045;
				h = 0.06;
				colorText[] = {0.8,0.6,0,1};
			};
			class RscPicture_81203: RscPictureGUI {
				idc = 81203;
				text = "custom\gui\icons\health.paa";
				x = safeZoneX + 0.077;
				y = safeZoneY + safeZoneH - 0.13;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,1};
			};
			class RscPicture_81204: RscPictureGUI {
				idc = 81204;
				text = "custom\gui\icons\food.paa";
				x = safeZoneX + 0.160;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,1};
			};
			class RscPicture_81205: RscPictureGUI {
				idc = 81205;
				text = "custom\gui\icons\drink.paa";
				x = safeZoneX + 0.235;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,1};
			};
			// Health border
			class RscPicture_81206: RscPictureGUI {
				idc = 81206;
				text = "custom\gui\icons\border_12.paa";
				x = safeZoneX + 0.07;
				y = safeZoneY + safeZoneH - 0.14;
				w = 0.06;
				h = 0.08;
				colorText[] = {1,1,1,1};
			};
			// Food border
			class RscPicture_81207: RscPictureGUI {
				idc = 81207;
				text = "custom\gui\icons\border_s_12.paa";
				x = safeZoneX + 0.160;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,1};
			};
			// Drink border
			class RscPicture_81208: RscPictureGUI {
				idc = 81208;
				text = "custom\gui\icons\border_s_12.paa";
				x = safeZoneX + 0.235;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,1};
			};
			class RscPicture_81209: RscPictureGUI {
				idc = 81209;
				text = "custom\gui\icons\bleed.paa";
				x = safeZoneX + 0.091;
				y = safeZoneY + safeZoneH - 0.107;
				w = 0.0225;
				h = 0.03;
				colorText[] = {1,0,0,0.8};
			};
			// Restart border
			class RscPicture_81210: RscPictureGUI {
				idc = 81210;
				text = "custom\gui\icons\border_s_12.paa";
				x = safeZoneX + safeZoneW - 0.175;
				y = safeZoneY + safeZoneH - 0.17;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
			};
			// Humanity border
			class RscPicture_81211: RscPictureGUI {
				idc = 81211;
				text = "custom\gui\icons\border_s_12.paa";
				x = safeZoneX + safeZoneW - 0.250;
				y = safeZoneY + safeZoneH - 0.17;
				w = 0.045;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
			};
		};

		class Controls {
			// Restart timer
			class RscText_81300: RscTextGUIK {
				idc = 81300;
				text = "";
				x = safeZoneX + safeZoneW - 0.182;
				y = safeZoneY + safeZoneH - 0.11;
				w = 0.06;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
				size = 0.035;
				sizeEx = 0.035;
			};
			// Humanity
			class RscText_81301: RscTextGUIK {
				idc = 81301;
				text = "";
				x = safeZoneX + safeZoneW - 0.257;
				y = safeZoneY + safeZoneH - 0.11;
				w = 0.06;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
				size = 0.035;
				sizeEx = 0.035;
			};
			// Money
			class RscText_81302: RscTextGUIK {
				idc = 81302;
				style = 0;
				text = "";
				x = safeZoneX + 0.370;
				y = safeZoneY + safeZoneH - 0.12;
				w = 0.20;
				h = 0.06;
				colorText[] = {1,1,1,0.7};
				size = 0.035;
				sizeEx = 0.035;
			};
		};
	};
};