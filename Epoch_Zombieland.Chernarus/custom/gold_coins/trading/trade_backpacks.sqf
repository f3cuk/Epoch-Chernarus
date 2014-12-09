private["_has_required","_oldPosition","_finished","_price","_newM","_removed","_trade_type","_classname","_display_name","_buyprice","_sellprice","_player_money"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_103") ,"PLAIN DOWN"]; };

DZE_ActionInProgress = true;

_trade_type			= (_this select 3) select 0;
_classname			= (_this select 3) select 1;
_display_name		= (_this select 3) select 2;
_buyprice			= (_this select 3) select 3;
_sellprice			= (_this select 3) select 4;
_player_money 		= player getVariable["cashMoney",0];

if(_trade_type == "buy") then {
	_has_required = (_player_money >= _buyprice);
} else {
	_has_required = (typeOf (unitBackpack player) == _classname);
};

if(_has_required) then {

	cutText[(localize "str_epoch_player_105"),"PLAIN DOWN"];
	 
	[1,1] call dayz_HungerThirst;

	if(isNil "_oldPosition") then {
		_oldPosition = position player;
	};

	_finished = false;

	sleep 1.5;

	if((position player) distance _oldPosition <= 0.1) then {
		_finished = true;
	};

	if(!_finished) exitWith { 
		r_interrupt = false;
		cutText["Cancelled trade" ,"PLAIN DOWN"];
	};

	if(_finished) then {

		if(isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };

		if(_trade_type == "buy") then {
			_price = [_buyprice] call BIS_fnc_numberText;

			if(_player_money >= _buyprice) then {

				player setVariable["cashMoney",(_player_money - _buyprice),true];

				_newM 		= player getVariable["cashMoney",0];
				_removed 	= _player_money - _newM;

				if(_removed == _buyprice) then {

					_price = [_buyprice] call BIS_fnc_numberText;

					removeBackpack player;
					player addBackpack _classname;

					cutText[format["Bought a %1 for %2 %3",_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
					systemChat format['[Trade] Bought a %1 for %2 %3',_display_name,_price,CurrencyAbbr];

					PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
					publicVariableServer "PVDZE_log";

				};

			} else {
				cutText["Cannot buy backpack, not enough money","PLAIN DOWN"];
			};
		} else {
			_price = [_sellprice] call BIS_fnc_numberText;

			if((typeOf (unitBackpack player)) == _classname) then {
				removeBackpack player;

				_price = [_sellprice] call BIS_fnc_numberText;
				player setVariable["cashMoney",(_player_money + _sellprice),true];

				cutText[format["Sold a %1 for %2 %3",_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
				systemChat format['[Trade] Sold a %1 for %2 %3',_display_name,_price,CurrencyAbbr];

				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) sold a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
				publicVariableServer "PVDZE_log";

			};
		};

		{
			player removeAction _x
		} forEach s_player_parts;

		s_player_parts = [];
		s_player_parts_crtl = -1;

	};

} else {

	if(_trade_type == "buy") then {
		cutText["Cannot buy backpack, not enough money","PLAIN DOWN"];
	} else {
		cutText["Cannot sell backpack, backpack not found","PLAIN DOWN"];
	};

};

DZE_ActionInProgress = false;