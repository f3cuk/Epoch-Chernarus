class MBC_Picture
{
    access = 0;
    idc = -1;
    type = 0;
    style = 2096;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "Bitstream";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};

class MBC_Button
{
    
    access = 0;
    type = 1;
    text = "";
    colorText[] = {0.8784,0.8471,0.651,1};
    colorDisabled[] = {0.4,0.4,0.4,0};
    colorBackground[] = {0,0,0,0.8};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0,0,0,0.8};
    colorFocused[] = {0,0,0,0.2};
    colorShadow[] = {0.023529,0,0.0313725,0};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "Bitstream";
    sizeEx = 0.03921;
    offsetX = 0;
    offsetY = 0;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
	period = 1.2;
	periodFocus = 1.2;
	periodOver = 1.2;
};

class MBC_Frame
{
    type = 0;
    idc = -1;
    style = 0x40;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "Bitstream";
    sizeEx = 0.03;
    text = "";
};

class MBC_TextBox
{
	access = 0;
	type = 0;
	idc = -1;
	colorBackground[] = {0,0,0,0};
	colorText[] = {1,1,1,0.9};
	text = "";
	fixedWidth = 0;
	x = 0;
	y = 0;
	h = 0.037;
	w = 0.3;
	style = 0;
	shadow = 2;
	font = "Zeppelin32";
	SizeEx = 0.03921;
	lineSpacing = 1;
	borderSize = 1;
	colorBorder[] = {0,0,0,1};
};

class MBC_DIALOG
{
	idd = 81000;
	movingenable = 0;
	enableSimulation = true;
	
	class Controls
	{
		class MBC_FRAME: MBC_Frame
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225926 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
		};
		class MBC_BG: MBC_TextBox
		{
			idc = -1;
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225926 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_TITLE: MBC_TextBox
		{
			idc = 81401;
			text = "";
			x = 0.29375 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.055 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
			colorText[] = {0.8784,0.8471,0.651,1};
			style = 2;
		};
		class MBC_REWARD_BG1: MBC_TextBox
		{
			idc = -1;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME1: MBC_Frame
		{
			idc = 81101;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_BG2: MBC_TextBox
		{
			idc = -1;
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME2: MBC_Frame
		{
			idc = 81102;
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_BG3: MBC_TextBox
		{
			idc = -1;
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME3: MBC_Frame
		{
			idc = 81103;
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.3075 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_BG4: MBC_TextBox
		{
			idc = -1;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME4: MBC_Frame
		{
			idc = 81104;
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_BG5: MBC_TextBox
		{
			idc = -1;
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME5: MBC_Frame
		{
			idc = 81105;
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_BG6: MBC_TextBox
		{
			idc = -1;
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {0,0,0,0.7};
		};
		class MBC_REWARD_FRAME6: MBC_Frame
		{
			idc = 81106;
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.48625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.165 * safezoneH;
		};
		class MBC_REWARD_PIC1: MBC_Picture
		{
			idc = 81201;
			text = "";
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.3175 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_REWARD_PIC2: MBC_Picture
		{
			idc = 81202;
			text = "";
			x = 0.467773 * safezoneW + safezoneX;
			y = 0.3175 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_REWARD_PIC3: MBC_Picture
		{
			idc = 81203;
			text = "";
			x = 0.590234 * safezoneW + safezoneX;
			y = 0.3175 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_REWARD_PIC4: MBC_Picture
		{
			idc = 81204;
			text = "";
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.49625 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_REWARD_PIC5: MBC_Picture
		{
			idc = 81205;
			text = "";
			x = 0.467773 * safezoneW + safezoneX;
			y = 0.49625 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_REWARD_PIC6: MBC_Picture
		{
			idc = 81206;
			text = "";
			x = 0.590234 * safezoneW + safezoneX;
			y = 0.49625 * safezoneH + safezoneY;
			w = 0.0634531 * safezoneW;
			h = 0.10 * safezoneH;
		};
		class MBC_CLAIM: MBC_Button
		{
			idc = 81402;
			text = "";
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.70625 * safezoneH + safezoneY;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			onButtonClick = "closeDialog 0;";
			colorText[] = {0.44,0.8,0,1};
			style = 2;
		};
		class MBC_REWARD_TEXT1: MBC_TextBox
		{
			idc = 81301;
			text = "";
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.4175 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_TEXT2: MBC_TextBox
		{
			idc = 81302;
			text = "";
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.4175 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_TEXT3: MBC_TextBox
		{
			idc = 81303;
			text = "";
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.4175 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_TEXT4: MBC_TextBox
		{
			idc = 81304;
			text = "";
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.59625 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_TEXT5: MBC_TextBox
		{
			idc = 81305;
			text = "";
			x = 0.441992 * safezoneW + safezoneX;
			y = 0.59625 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_TEXT6: MBC_TextBox
		{
			idc = 81306;
			text = "";
			x = 0.564453 * safezoneW + safezoneX;
			y = 0.59625 * safezoneH + safezoneY + 0.01;
			w = 0.116016 * safezoneW;
			h = 0.055 * safezoneH;
			style = 530;
			SizeEx = 0.034;
		};
		class MBC_REWARD_CAUTIONTEXT: MBC_TextBox
		{
			idc = 81403;
			text = "";
			x = 0.319531 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.360937 * safezoneW;
			h = 0.0275 * safezoneH;
			SizeEx = 0.03;
		};
	};
};
