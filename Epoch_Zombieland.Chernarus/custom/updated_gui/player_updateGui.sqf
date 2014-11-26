private ["_wealth","_coindisplay","_display","_ctrlBlood","_ctrlBleed","_bloodVal","_ctrlFood","_ctrlThirst","_thirstVal","_foodVal","_ctrlTemp","_tempVal","_combatVal","_array","_ctrlEar","_ctrlEye","_ctrlCombat","_ctrlFracture","_visual","_audible","_blood","_thirstLvl","_foodLvl","_tempImg","_thirst","_food","_temp","_bloodLvl","_tempLvl","_color","_string","_humanity","_size","_friendlies","_rfriendlies","_rfriendlyTo","_distance","_targetControl","_playerUID","_rplayerUID","_ctrlBloodOuter","_ctrlFoodBorder","_ctrlThirstBorder","_ctrlTempBorder"];

disableSerialization;

_foodVal 				= 1 - (dayz_hunger / SleepFood);
_thirstVal 				= 1 - (dayz_thirst / SleepWater);
_tempVal 				= 1 - ((dayz_temperatur - dayz_temperaturmin)/(dayz_temperaturmax - dayz_temperaturmin));
_combatVal 				= 1 - dayz_combat;

if (uiNamespace getVariable ["DZ_displayUI", 0] == 1) exitWith {
	_array = [_foodVal,_thirstVal];
	_array
};

_display 				= uiNamespace getVariable 'DAYZ_GUI_display';

_ctrlBloodOuter 		= _display displayCtrl 1200;
_ctrlFoodBorder 		= _display displayCtrl 1201;
_ctrlThirstBorder 		= _display displayCtrl 1202;
_ctrlTempBorder 		= _display displayCtrl 1208;

//Border white
_ctrlBloodOuter 		ctrlSetTextColor [1,1,1,1];
_ctrlFoodBorder 		ctrlSetTextColor [1,1,1,1];
_ctrlThirstBorder 		ctrlSetTextColor [1,1,1,1];
_ctrlTempBorder 		ctrlSetTextColor [1,1,1,1];

_ctrlBlood 				= _display displayCtrl 1300;
_ctrlBleed 				= _display displayCtrl 1303;
_bloodVal 				= r_player_blood / r_player_bloodTotal;
_ctrlFood 				= _display displayCtrl 1301;
_ctrlThirst 			= _display displayCtrl 1302;
_ctrlTemp				= _display displayCtrl 1306;
_ctrlEar 				= _display displayCtrl 1304;
_ctrlEye 				= _display displayCtrl 1305;
_ctrlCombat 			= _display displayCtrl 1307;
_ctrlFracture 			= _display displayCtrl 1203;

_ctrlBloodAmount 		= _display displayCtrl 1420;
_ctrlHumanityAmount 	= _display displayCtrl 1421;
_ctrlServerRestart 		= _display displayCtrl 1422;

_bloodTotal 			= r_player_blood;
_RestartTime 			= 240-(round(serverTime/60));

_ctrlBloodAmount  		ctrlSetText str(round(_bloodTotal/120));
_ctrlHumanityAmount 	ctrlSetText str(player getVariable["humanity", 0]);
_ctrlServerRestart  	ctrlSetText str(_RestartTime);

_ctrlFPS 				= _display displayCtrl 1321;
_ctrlFPSOuter 			= _display displayCtrl 1322;

_fps 					= round diag_FPS;
_ctrlFPS 				ctrlSetText str(_fps);
_ctrlFPS 				ctrlSetTextColor [0.6, 0.73, 0.0, 0.75];

_ctrlhumanKills 		= _display displayCtrl 1400;
_ctrlbanditKills 		= _display displayCtrl 1402;
_ctrlzombieKills 		= _display displayCtrl 1403;

_ctrlhumanKills  		ctrlSetText str(player getVariable["humanKills", 0]);
_ctrlbanditKills 		ctrlSetText str(player getVariable["banditKills", 0]);
_ctrlzombieKills 		ctrlSetText str(player getVariable["zombieKills", 0]);

//Food/Water/Blood
_ctrlBlood ctrlSetTextColor 	[(Dayz_GUI_R + (0.3 * (1-_bloodVal))),(Dayz_GUI_G * _bloodVal),(Dayz_GUI_B * _bloodVal), 0.5];
_ctrlFood ctrlSetTextColor 		[(Dayz_GUI_R + (0.3 * (1-_foodVal))),(Dayz_GUI_G * _foodVal),(Dayz_GUI_B * _foodVal), 0.5];
_ctrlThirst ctrlSetTextColor 	[(Dayz_GUI_R + (0.3 * (1-_thirstVal))),(Dayz_GUI_G * _thirstVal),(Dayz_GUI_B * _thirstVal), 0.5];
_ctrlTemp ctrlSetTextColor 		[(Dayz_GUI_R + (0.3 * (1-_tempVal))), (Dayz_GUI_G * _tempVal), _tempVal, 0.5];
_ctrlCombat ctrlSetTextColor	[(Dayz_GUI_R + (0.3 * (1-_combatVal))),(Dayz_GUI_G * _combatVal),(Dayz_GUI_B * _combatVal), 0.5];

_blood 					= "";
_thirst 				= "";
_food 					= "";
_temp 					= "";
_tempImg 				= 0;
_bloodLvl 				= round((r_player_blood / 2) / 1000);
_thirstLvl 				= round(_thirstVal / 0.25);
_foodLvl 				= round(_foodVal / 0.25);
_tempLvl 				= round(dayz_temperatur);

if (_bloodLvl <= 0) then { 
	_blood 			= "\z\addons\dayz_code\gui\status\status_blood_inside_1_ca.paa";
} else {
	_blood 			= "\z\addons\dayz_code\gui\status\status_blood_inside_" + str(_bloodLvl) + "_ca.paa";
};

if (_thirstLvl < 0) then { 
	_thirstLvl = 0
};

_thirst 			= "\z\addons\dayz_code\gui\status\status_thirst_inside_" + str(_thirstLvl) + "_ca.paa";

if (_foodLvl < 0) then {
	_foodLvl = 0
};

_food 				= "\z\addons\dayz_code\gui\status\status_food_inside_" + str(_foodLvl) + "_ca.paa";

if ( _tempLvl >= 36 )							then { _tempImg = 4 };
if ( _tempLvl > 33 && _tempLvl < 36 )			then { _tempImg = 3 };
if ( _tempLvl >= 30 && _tempLvl <= 33 )			then { _tempImg = 2 };
if ( _tempLvl > 28 && _tempLvl < 30 )			then { _tempImg = 1 };
if ( _tempLvl <= 28 )							then { _tempImg = 0 };

_temp				= "\z\addons\dayz_code\gui\status\status_temp_" + str(_tempImg) + "_ca.paa";

_ctrlBlood 			ctrlSetText _blood;
_ctrlThirst 		ctrlSetText _thirst;
_ctrlFood 			ctrlSetText _food;
_ctrlTemp 			ctrlSetText _temp;

_visual = (dayz_disVisual / 185) min 1;
if (_visual < 0.2) then {_visual = 0.2;};
_ctrlEye ctrlSetTextColor [1, 1, 1, _visual];

_audible = (dayz_disAudial / 40) min 1;
if (_audible < 0.2) then {_audible = 0.2;};
_ctrlEar ctrlSetTextColor [1, 1, 1, _audible];

if (!canStand player) then {
	if (!(ctrlShown _ctrlFracture)) then {
		r_fracture_legs = true;
		_ctrlFracture ctrlShow true;
	};
};

_ctrl_Array=[];

if (_combatVal == 0) then {
	_ctrl_Array=_ctrl_Array + [_ctrlCombat];	 
} else {
	_ctrlCombat ctrlShow true;
};

if (_bloodVal < 0.4) then {
	_ctrl_Array=_ctrl_Array + [_ctrlBlood];
} else {
	_ctrlBlood ctrlShow true;
};

if (_thirstVal < 0.2) then {
	_ctrl_Array=_ctrl_Array + [_ctrlThirst];
} else {
	_ctrlThirst ctrlShow true;
};

if (_foodVal < 0.2) then {
	_ctrl_Array=_ctrl_Array + [_ctrlFood];
} else {
	_ctrlFood ctrlShow true;
};

if (_tempVal > 0.8) then {
	_ctrl_Array=_ctrl_Array + [_ctrlTemp];
} else {
	_ctrlTemp ctrlShow true;
};

if (r_player_injured) then {
	_ctrl_Array=_ctrl_Array + [_ctrlBleed];
} else {
	_ctrlBleed ctrlShow false;
};

if((count _ctrl_Array) > 0) then {
	_ctrl_Array call player_guiControlFlash;
};

_string 			= "";
_humanityTarget 	= cursorTarget;

if (!isNull _humanityTarget && isPlayer _humanityTarget && alive _humanityTarget) then {

	_distance = player distance _humanityTarget;

	if (_distance < DZE_HumanityTargetDistance) then {
		
		_size 			= (1-(floor(_distance/5)*0.1)) max 0.1;
		_friendlies 	= player getVariable ["friendlies", []];
		_playerUID 		= getPlayerUID player;
		_rplayerUID 	= getPlayerUID _humanityTarget;
		_rfriendlies 	= _humanityTarget getVariable ["friendlies", []];
		_rfriendlyTo 	= _humanityTarget getVariable ["friendlyTo", []];

		if ((_rplayerUID in _friendlies) && (_playerUID in _rfriendlies)) then {
		
			if !(_playerUID in _rfriendlyTo) then {
				_rfriendlyTo set [count _rfriendlyTo, _playerUID];
				_humanityTarget setVariable ["friendlyTo", _rfriendlyTo, true];
			};
	
			_color = "color='#339933'";
			_string = format["<t %2 align='center' size='%3'>%1</t>",(name _humanityTarget),_color,_size];
		
		} else {

			// Humanity checks
			_humanity = _humanityTarget getVariable ["humanity",0];

			_color = "color='#ffffff'";
			
			if(_humanity < -5000) then {
				_color = "color='#ff0000'";
			} else {
				if(_humanity > 5000) then {
					_color = "color='#3333ff'";
				};
			};
			
			if((_humanityTarget getVariable ["DZE_display_name", false]) || (DZE_ForceNameTagsInTrader && isInTraderCity)) then {
				_string = format["<t %2 align='center' size='%3'>%1</t>",(name _humanityTarget),_color,_size];
			};
		};
	};
};

// update gui if changed
if (dayz_humanitytarget != _string) then {
	_targetControl = _display displayCtrl 1199;
	_targetControl ctrlSetStructuredText (parseText _string);
	dayz_humanitytarget = _string;
};

_wealth = player getVariable ["cashMoney",0];

if(dayz_wealth != _wealth) then {

	_coindisplay	= uiNamespace getVariable 'DAYZ_GUI_COINS_display';
	dayz_wealth 	= _wealth;
	_wealth 		= if(typeName _wealth == "STRING") then { parseNumber _wealth } else { _wealth };
	_wealth 		= [_wealth] call BIS_fnc_numberText;
	_wealth 		= format["<t size='1' align='left' valign='middle'><img image='custom\gold_coins\resources\img\coins.paa' /> %1</t>",_wealth];

	_targetControl	= _coindisplay displayCtrl 1;
	_targetControl ctrlSetStructuredText (parseText _wealth);
};

_array = [_foodVal,_thirstVal];
_array