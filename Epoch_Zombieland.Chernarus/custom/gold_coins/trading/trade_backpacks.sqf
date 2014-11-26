private ["_oldPosition","_part_out","_part_in","_qty_out","_qty_in","_qty","_bos","_bag","_class","_started","_finished","_animState","_isMedic","_num_removed","_needed","_activatingPlayer","_buy_o_sell","_textPartIn","_textPartOut","_traderID"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_103") , "PLAIN DOWN"]; };

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
_bos = 0;

if(_buy_o_sell == "buy") then {
	_qty = player getVariable ["cashMoney",0];
} else {
	_bos = 1;
	_qty = 0;
	_bag = unitBackpack player;
	_class = typeOf _bag;
	if(_class == _part_in) then {
		_qty = 1;
	};
};

if (_qty >= _qty_in) then {

	cutText [(localize "str_epoch_player_105"), "PLAIN DOWN"];
	 
	[1,1] call dayz_HungerThirst;

	// # F3 FAST TRADING

		if(isNil "_oldPosition") then {
			_oldPosition = position player;
		};

		_finished = false;

		sleep 1.5;
		
		if ((position player) distance _oldPosition <= 0.1) then {
			_finished = true;
		};

		if (!_finished) exitWith { 
			r_interrupt = false;
			cutText ["Cancelled trade" , "PLAIN DOWN"];
		};

	// # F3 FAST TRADING

	if (_finished) then {

		// Double check we still have parts
		if(_buy_o_sell == "buy") then {
			//_qty = {_x == _part_in} count magazines player;
			_qty = player getVariable ["cashMoney",0]; // get your money variable	
		} else {
			_qty = 0;
			_bag = unitBackpack player;
			_class = typeOf _bag;
			if(_class == _part_in) then {
				_qty = 1;
			};
		};

		if (_qty >= _qty_in) then {

			if (isNil "_bag") then { _bag = "Unknown Backpack" };
			if (isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };
			if (_bos == 1) then {
				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5x %6",(name _activatingPlayer),(getPlayerUID _activatingPlayer),_part_in,inTraderCity,_qty_out,CurrencyName]];
			} else {
				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) sold a %3 in/at %4 for %5x %6",(name _activatingPlayer),(getPlayerUID _activatingPlayer),_part_out,inTraderCity,_qty_in,CurrencyName]];
			};
			publicVariableServer "PVDZE_log";
	
			// waitUntil {!isNil "dayzTradeResult"};
			dayzTradeResult = "PASS";

			if(dayzTradeResult == "PASS") then {

				if(_buy_o_sell == "buy") then {
			
					_curr_new = _qty - _qty_in;
				
					player setVariable ["cashMoney",_curr_new,true];
					
					_newM 		= player getVariable ["cashMoney",0];
					_removed 	= _qty - _newM;
														
					if(_removed == _qty_in) then {
					
						_price = [_qty_in] call BIS_fnc_numberText;

						removeBackpack player;
						player addBackpack _part_out;

						cutText [format["[Trade] Bought a %1 for %2 %3",_textPartOut,_price,CurrencyName], "PLAIN DOWN"];

					};
				} else {
					// Sell
					if((typeOf (unitBackpack player)) == _part_in) then {
						removeBackpack player;
						
						_price = [_qty_out] call BIS_fnc_numberText;
						
						_myMoney = player getVariable ["cashMoney",0];
						_myMoney = _myMoney + _qty_out;
						player setVariable ["cashMoney",_myMoney,true];
						
						cutText [format["[Trade] Sold a %1 for %2 %3",_textPartIn,_price,CurrencyName], "PLAIN DOWN"];

					};
				};

				{
					player removeAction _x
				} forEach s_player_parts;

				s_player_parts = [];
				s_player_parts_crtl = -1;
	
			} else {
				cutText [format[(localize "str_epoch_player_183"),_textPartOut] , "PLAIN DOWN"];
			};
			dayzTradeResult = nil;
		};
	};
	
} else {
	_needed =  _qty_in - _qty;
	cutText [format["You need %1 more %2",_needed,_textPartIn] , "PLAIN DOWN"];
};

DZE_ActionInProgress = false;