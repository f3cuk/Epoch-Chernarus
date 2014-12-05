private["_oldPosition","_part_out","_part_in","_qty_out","_qty_in","_qty","_buy_o_sell","_traderID","_bos","_needed","_activatingPlayer","_textPartIn","_textPartOut","_finished","_removed","_msg","_config","_configName","_wepType","_isToolBelt","_isBinocs","_abort","_secondaryWeapon","_isPistol","_isRifle","_qtychange","_newM","_myMoney"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_103") ,"PLAIN DOWN"]; };

DZE_ActionInProgress = true;

_activatingPlayer = player;

_part_out 		= (_this select 3) select 0;
_part_in 		= (_this select 3) select 1;
_qty_out 		= (_this select 3) select 2;
_qty_in 		= (_this select 3) select 3;
_buy_o_sell 	= (_this select 3) select 4;
_textPartIn 	= (_this select 3) select 5;
_textPartOut 	= (_this select 3) select 6;
_traderID 		= (_this select 3) select 7;
_bos 			= 0;
_abort 			= false;
_msg 			= "";

if(_buy_o_sell == "sell") then {
	_qty = {_x == _part_in} count weapons player;
	_bos = 1;

	_msg 		= "Need the weapon in your hands before you can sell it.";
	_config 	= (configFile >> "CfgWeapons" >> _part_in);
	_configName = configName(_config);
	_wepType 	= getNumber(_config >> "Type");

	_isToolBelt = (_wepType == 131072);
	_isBinocs 	= (_wepType == 4096);

	_abort 		= (!(_configName in (weapons player)));

	if(_isToolBelt || _isBinocs) then {
		_msg = "Need the item on your toolbelt before you can sell it.";
	};

} else {

	_qty 		= player getVariable["cashMoney",0]; 
	_msg 		= "Drop or sell your current weapon before you can buy a new one.";
	_config 	= (configFile >> "CfgWeapons" >> _part_out);
	_configName = configName(_config);
	_wepType 	= getNumber(_config >> "Type");

	_isPistol = (_wepType == 2);
	_isRifle = (_wepType == 1);
	_isToolBelt = (_wepType == 131072);
	_isBinocs = (_wepType == 4096);

	if(_isRifle) then {
		_abort = ((primaryWeapon player) != "");
	};
	if(_isPistol) then {
		_secondaryWeapon = "";
		{
			if((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith {
					_secondaryWeapon = _x;
			};
		} count (weapons player);
		_abort = (_secondaryWeapon != "");
	};
	if(_isToolBelt || _isBinocs) then {
		_abort = (_configName in (weapons player));
		_msg = "Drop or sell your current toolbelt item before you can buy a new one.";
	};
};

if(_abort) exitWith {
	cutText[_msg,"PLAIN DOWN"];
	DZE_ActionInProgress = false;
};

if(_qty >= _qty_in) then {

	cutText[(localize "str_epoch_player_105"),"PLAIN DOWN"];
	 
	[1,1] call dayz_HungerThirst;

	// # F3 FAST TRADING

		if(isNil "_oldPosition") then {
			_oldPosition = position player;
		};

		_finished = false;

		sleep .5;

		if((position player) distance _oldPosition <= 0.1) then {
			_finished = true;
		};

		if(!_finished) exitWith {
			DZE_ActionInProgress = false;
			cutText["Cancelled trade","PLAIN DOWN"];
		};

	// # F3 FAST TRADING

	if(_finished) then {

		if(_buy_o_sell == "buy") then {
			_qty = player getVariable["cashMoney",0];	
		} else {
			_qty = {_x == _part_in} count weapons player;
		};

		if(_qty >= _qty_in) then {

			if(isNil "_part_out") then { _part_out = "Unknown Weapon/Magazine" };
			if(isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };
			if(_bos == 1) then {
				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5x %6",(name _activatingPlayer),(getPlayerUID _activatingPlayer),_part_in,inTraderCity,_qty_out,CurrencyName]];
			} else {
				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) sold a %3 in/at %4 for %5x %6",(name _activatingPlayer),(getPlayerUID _activatingPlayer),_part_out,inTraderCity,_qty_in,CurrencyName]];
			};
			publicVariableServer "PVDZE_log";

			// waitUntil {!isNil "dayzTradeResult"};
			dayzTradeResult = "PASS";

			if(dayzTradeResult == "PASS") then {

				if(_buy_o_sell == "buy") then {

					_qtychange = _qty - _qty_in;
					player setVariable["cashMoney",_qtychange ,true];	
					_newM = player getVariable["cashMoney",0];
					_removed = _qty - _newM; // 

					if(_removed == _qty_in) then {
						for "_x" from 1 to _qty_out do {
							player addWeapon _part_out;
						};
						cutText[format[(localize "str_epoch_player_186"),_qty_in,_textPartIn,_qty_out,_textPartOut],"PLAIN DOWN"];
					};

				} else {

					_removed = ([player,_part_in,_qty_in] call BIS_fnc_invRemove);

					if(_removed == _qty_in) then {

						_myMoney = player getVariable["cashMoney",0];
						_myMoney = _myMoney + _qty_out;
						player setVariable["cashMoney",_myMoney ,true];	

						cutText[format[(localize "str_epoch_player_186"),_qty_in,_textPartIn,_qty_out,_textPartOut],"PLAIN DOWN"];
					};
				};

				{
					player removeAction _x
				} forEach s_player_parts;

				s_player_parts 		= [];
				s_player_parts_crtl = -1;

			} else {
				cutText[format[(localize "str_epoch_player_183"),_textPartOut] ,"PLAIN DOWN"];
			};

			dayzTradeResult = nil;
		};
	};

} else {
	_needed = _qty_in - _qty;
	cutText[format[(localize "str_epoch_player_184"),_needed,_textPartIn] ,"PLAIN DOWN"];
};

DZE_ActionInProgress = false;