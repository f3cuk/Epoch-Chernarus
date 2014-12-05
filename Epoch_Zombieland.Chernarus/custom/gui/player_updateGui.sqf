private["_invert","_combattimeout","_timeleft","_humanity_b","_ctrl_humanity_b","_ctrl_restart_b","_restart_c","_restart_b","_foodVal","_thirstVal","_combatVal","_bloodVal","_calculate_color","_array","_humanity","_money","_restart","_display","_blood","_thirst","_food","_update_array","_ctrl_array","_ctrl_restart","_ctrl_restart_c","_ctrl_humanity","_ctrl_humanity_c","_ctrl_money","_ctrl_blood","_ctrl_blood_b","_ctrl_bleed","_ctrl_food","_ctrl_food_b","_ctrl_drink","_ctrl_drink_b","_blood_number","_blood_color","_food_number","_food_color","_thirst_number","_thirst_color","_string","_distance","_size","_friendlies","_playerUID","_rplayerUID","_rfriendlies","_rfriendlyTo","_color","_humanity_t","_targetControl","_h","_m","_ctrl_money_c","_humanityTarget"];

disableSerialization;

_foodVal	= 1 - (dayz_hunger / SleepFood);
_thirstVal	= 1 - (dayz_thirst / SleepWater);
_combatVal	= 1 - dayz_combat;
_bloodVal 	= r_player_blood;

if(uiNamespace getVariable["DZ_displayUI",0] == 1) then {
	_array = [_foodVal,_thirstVal];
	_array
} else {

	_calculate_color = {
		private["_val","_val_rev","_bl_color"];

		_val		= (_this / 12);
		_val_rev	= 1 - _val;
		_bl_color 	= [1,_val,_val,(0.4 + (1 - _val_rev))];

		_bl_color
	};

	_humanity 		= player getVariable["humanity",0];
	_money			= player getVariable["cashMoney",0];
	_restart		= 240-(round(serverTime/60));
	_update_array 	= [];
	_ctrl_array 	= [];

	if(_foodVal != foodVal_CHK) then {
		_update_array set[count _update_array,"food"];
		foodVal_CHK = _foodVal;
	};

	if(_thirstVal != thirstVal_CHK) then {
		_update_array set[count _update_array,"thirst"];
		thirstVal_CHK = _thirstVal;
	};

	if(_combatVal != combatVal_CHK) then { 
		_update_array set[count _update_array,"combat"];
		combatVal_CHK = _combatVal;
	};

 	if(_bloodVal != bloodVal_CHK) then {
 		_update_array set[count _update_array,"blood"];
 		bloodVal_CHK = _bloodVal;
 	};

	if(_humanity != humanity_CHK) then {
		_update_array set[count _update_array,"humanity"];
		humanity_CHK = _humanity;
	};

	if(_money != money_CHK) then {
		_update_array set[count _update_array,"money"];
		money_CHK = _money;
	};

	if(_restart != restart_CHK) then {
		_update_array set[count _update_array,"restart"];
		restart_CHK = _restart;
	};

	_display = uiNamespace getVariable 'DAYZ_GUI_display';

	_ctrl_restart		= _display displayCtrl 81200;
	_ctrl_restart_c		= _display displayCtrl 81300;
	_ctrl_restart_b		= _display displayCtrl 81210;
	_ctrl_humanity		= _display displayCtrl 81201;
	_ctrl_humanity_c	= _display displayCtrl 81301;
	_ctrl_humanity_b	= _display displayCtrl 81211;
	_ctrl_money			= _display displayCtrl 81202;
	_ctrl_money_c		= _display displayCtrl 81302;
	_ctrl_blood			= _display displayCtrl 81203;
	_ctrl_blood_b		= _display displayCtrl 81206;
	_ctrl_bleed			= _display displayCtrl 81209;
	_ctrl_food			= _display displayCtrl 81204;
	_ctrl_food_b		= _display displayCtrl 81207;
	_ctrl_drink			= _display displayCtrl 81205;
	_ctrl_drink_b		= _display displayCtrl 81208;

	if(!isNil "dayz_animalCheck") then {
		if(isNil "firstrun") then {
			_update_array = ["food","thirst","combat","blood","humanity","money","restart"];
		} else {
			firstrun = false;
		};
	};

	if("humanity" in _update_array) then {
		if(_humanity > 1000 || _humanity < -1000) then {
			_humanity = format["%1K",(round(_humanity/100)/10)];
		} else {
			_humanity = format["%1",_humanity];
		};
		_ctrl_humanity_c ctrlSetText _humanity;
	};

	if("money" in _update_array) then {
		_money = [_money] call BIS_fnc_numberText;

		_ctrl_money_c ctrlSetText _money;
	};

	if("restart" in _update_array) then {

		if(round(_restart/20) > 0) then {
			_restart_b = "custom\gui\icons\border_" + str(round(_restart/20)) + ".paa";
		} else {
			_restart_b = "";
		};

		if(_restart > 60) then {
			_h = floor(_restart/60);
			_m = round(_restart % 60);
			if(_m != 0) then {
				_restart_c = format["%1h%2m",_h,_m];
			} else {
				_restart_c = format["%1h",_h];
			};
		} else {
			_restart_c = format["%1m",_restart];
		};
		_ctrl_restart_c ctrlSetText _restart_c;
		_ctrl_restart_b ctrlSetText _restart_b;
	};

	if("blood" in _update_array) then {
		_blood_number = (_bloodVal/1000);
		_blood_color = (_bloodVal/1000) call _calculate_color;
		if(round(_blood_number) > 0) then { 
			_blood = "custom\gui\icons\border_" + str(round(_blood_number)) + ".paa";
		} else {
			_blood = "";
		};
		_ctrl_blood ctrlSetTextColor _blood_color;
		_ctrl_blood_b ctrlSetTextColor _blood_color;
		_ctrl_blood_b ctrlSetText _blood;
	};

	if("food" in _update_array) then {
		_food_number = ((_foodVal*1.2)*10);
		_food_color = _food_number call _calculate_color;
		if(round(_food_number) > 0) then {
			_food = "custom\gui\icons\border_s_" + str(round(_food_number)) + ".paa";
		} else {
			_food = "";
		};
		_ctrl_food ctrlSetTextColor _food_color;
		_ctrl_food_b ctrlSetTextColor _food_color;
		_ctrl_food_b ctrlSetText _food;
	};

	if("thirst" in _update_array) then {	
		_thirst_number = ((_thirstVal*1.2)*10);
		_thirst_color = _thirst_number call _calculate_color;
		if(round(_thirst_number) > 0) then {
			_thirst	= "custom\gui\icons\border_s_" + str(round(_thirst_number)) + ".paa";
		} else {
			_thirst = "";
		};
		_ctrl_drink ctrlSetTextColor _thirst_color;
		_ctrl_drink_b ctrlSetTextColor _thirst_color;
		_ctrl_drink_b ctrlSetText _thirst;
	};

	_update_array = nil;

	if(_combatVal == 0) then {
		_ctrl_array set[count _ctrl_array,_ctrl_humanity];
		_combattimeout = player getVariable["combattimeout",(time + 30)];

		if(_combattimeout > 0) then {
			_timeleft = _combattimeout - time;
			_invert = 12 - ceil((_timeleft / 30) * 12);
			if(_invert > 0) then {
				_humanity_b	= "custom\gui\icons\border_s_" + str(_invert) + ".paa";
			} else {
				_humanity_b = "";
			};
		} else {
			_humanity_b = "";
		};

		_ctrl_humanity_b ctrlSetText _humanity_b;

	} else {
		_ctrl_humanity ctrlShow true;
	};

	if(_thirstVal < 0.2) then {
		_ctrl_array set[count _ctrl_array,_ctrl_drink];
	} else {
		_ctrl_drink ctrlShow true;
	};

	if(_foodVal < 0.2) then {
		_ctrl_array set[count _ctrl_array,_ctrl_food];
	} else {
		_ctrl_food ctrlShow true;
	};

	if(_bloodVal < 3000) then {
		_ctrl_array set[count _ctrl_array,_ctrl_blood];
	} else {
		_ctrl_blood ctrlShow true;
	};

	if(r_player_injured) then {
		_ctrl_array set[count _ctrl_array,_ctrl_bleed];
	} else {
		_ctrl_bleed ctrlShow false;
	};

	if(_restart < 6) then {
		_ctrl_array set[count _ctrl_array,_ctrl_restart];
		if(_restart < 1) then {
			_ctrl_restart ctrlSetTextColor [1,0,0,1];
		};
	} else {
		_ctrl_restart ctrlShow true;
	};

	if((count _ctrl_array) > 0) then {
		_ctrl_array call player_guiControlFlash;
	};

	_string			= "";
	_humanityTarget	= cursorTarget;

	if(!isNull _humanityTarget && isPlayer _humanityTarget && alive _humanityTarget) then {

		_distance = player distance _humanityTarget;

		if(_distance < DZE_HumanityTargetDistance) then {

			_size			= (1-(floor(_distance/5)*0.1)) max 0.1;
			_friendlies		= player getVariable["friendlies",[]];
			_playerUID		= getPlayerUID player;
			_rplayerUID		= getPlayerUID _humanityTarget;
			_rfriendlies	= _humanityTarget getVariable["friendlies",[]];
			_rfriendlyTo	= _humanityTarget getVariable["friendlyTo",[]];

			if((_rplayerUID in _friendlies) && (_playerUID in _rfriendlies)) then {

				if !(_playerUID in _rfriendlyTo) then {
					_rfriendlyTo set[count _rfriendlyTo,_playerUID];
					_humanityTarget setVariable["friendlyTo",_rfriendlyTo,true];
				};

				_color	= "color='#339933'";
				_string	= format["<t %2 align='center' size='%3'>%1</t>",(name _humanityTarget),_color,_size];

			} else {

				_humanity_t	= _humanityTarget getVariable["humanity",0];
				_color		= "color='#ffffff'";

				if(_humanity_t < -5000) then {
					_color = "color='#ff0000'";
				} else {
					if(_humanity_t > 5000) then {
						_color = "color='#3333ff'";
					};
				};

				if((_humanityTarget getVariable["DZE_display_name",false]) || (DZE_ForceNameTagsInTrader && isInTraderCity)) then {
					_string = format["<t %2 align='center' size='%3'>%1</t>",(name _humanityTarget),_color,_size];
				};
			};
		};
	};

	if(dayz_humanitytarget != _string) then {
		_targetControl = _display displayCtrl 1199;
		_targetControl ctrlSetStructuredText (parseText _string);
		dayz_humanitytarget = _string;
	};

	_array = [_foodVal,_thirstVal];
	_array

};