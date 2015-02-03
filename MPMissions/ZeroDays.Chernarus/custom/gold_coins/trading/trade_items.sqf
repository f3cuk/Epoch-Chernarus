private ["_needed","_total_trades","_oldPosition","_finished","_player_money","_emptySlots","_free_magazine_slots","_removed","_trade_type","_classname","_display_name","_buyprice","_sellprice","_finish_trade","_price"];

if(DZE_ActionInProgress) exitWith { cutText["Trade already in progress.","PLAIN DOWN"]; };
if(isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };

DZE_ActionInProgress = true;

_trade_type		= (_this select 3) select 0;
_classname 		= (_this select 3) select 1;
_display_name 	= (_this select 3) select 2;
_buyprice 		= (_this select 3) select 3;
_sellprice		= (_this select 3) select 4;
_player_money	= player getVariable["cashMoney",0];
_trade_num		= 1;

_finish_trade = {
	{
		player removeAction _x
	} count s_player_parts;

	s_player_parts			= [];
	s_player_parts_crtl		= -1;
	DZE_ActionInProgress	= false;
	dayzTradeResult			= nil;
};

if(_trade_type == "buy") then {
	_emptySlots				= [player] call BIS_fnc_invSlotsEmpty;
	_free_magazine_slots	= _emptySlots select 4;
	_tradeCounter			= 0;

	if(_free_magazine_slots < 1) exitWith { 
		cutText["You have no room in your inventory.","PLAIN DOWN"];
		DZE_ActionInProgress = false;
	};

	_total_trades = floor(_player_money / _buyprice);

	if(_total_trades < 1) exitWith {
		_needed = _buyprice - _player_money;
		cutText[format["You need another %1 %2",_needed,CurrencyAbbr],"PLAIN DOWN"];
		call _finish_trade;
	};

	if(_total_trades > _free_magazine_slots) then {
		_total_trades = _free_magazine_slots;
	};

	if(_total_trades > 1) then {

		createDialog 'RscDisplayPassword';

		ctrlSetText[1001,format["Buy %1 - %2 coins each",_display_name,_buyprice]];
		ctrlSetText[1002,format['Max (%1)',_total_trades]];
		ctrlSetText[101,''];
		buttonSetaction[1,'tradeNum = (ctrlText 101)'];

		waitUntil{!dialog};

		if(isNil "tradeNum") exitWith {
			cutText["Cancelled trade","PLAIN DOWN"];
			call _finish_trade;
		};

		tradeNum = parseNumber(tradeNum);

		if(typeName tradeNum != "SCALAR" || tradeNum < 1 || tradeNum > _total_trades) then {
			cutText["Incorrect value","PLAIN DOWN"];
			call _finish_trade;
		} else {
			_trade_num = tradeNum;
		};
		tradeNum = nil;
	};

	_price = [(_buyprice*_trade_num)] call BIS_fnc_numberText;

	cutText["Starting trade, stand still to complete trade","PLAIN DOWN"];

	if(isNil "_oldPosition") then {
		_oldPosition = position player;
	};

	_finished = false;

	sleep .5;

	if((position player) distance _oldPosition <= 0.1) then {
		_finished = true;
	};

	if(!_finished) exitWith {
		r_interrupt = false;
		cutText["Cancelled trade","PLAIN DOWN"];
	};

	if(_finished) then {

		_player_money = player getVariable["cashMoney",0];

		if(_player_money >= (_buyprice * _trade_num)) then {

			player setVariable["cashMoney",(_player_money - (_buyprice * _trade_num)),true];

			for "_i" from 1 to _trade_num do {
				player addMagazine _classname;
			};

			PVDZE_plr_Save = [player,(magazines player),true,true];
			publicVariableServer "PVDZE_plr_Save";

			cutText[format["Bought %1 %2 for %3 %4",_trade_num,_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
			systemChat format['[Trade] Bought %1 %2 for %3 %4',_display_name,_price,CurrencyAbbr];

			PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
			publicVariableServer "PVDZE_log";

			if(_classname in ["ItemBriefcase_Base","ItemSilvercase_Base"]) then {
				[
					format["<t size='0.40' color='#FFFFFF' align='right'>%1</t><br /><t size='0.70' color='#d5a040' align='right'>%2</t>",name player,"Good luck with your EpochPack!"],
					[safezoneX + safezoneW - 0.8,0.50],
					[safezoneY + safezoneH - 0.8,0.7],
					10,
					0.5
				] spawn BIS_fnc_dynamicText;
			};

		} else {
			_needed = (_buyprice * _trade_num) - _player_money;
			cutText[format["You need another %1 %2",_needed,CurrencyAbbr] ,"PLAIN DOWN"];
		};
	};

} else {
	_removed 		= 0;
	_tradeCounter 	= 0;
	_total_trades 	= {_x == _classname} count magazines player;

	if(_total_trades < 1) exitWith {
		cutText[format["You do not have a %1",_display_name],"PLAIN DOWN"];
		call _finish_trade;
	};

	if(_total_trades > 1) then {

		createDialog 'RscDisplayPassword';

		ctrlSetText[1001,format["Sell %1 - %2 coins each",_display_name,_buyprice]];
		ctrlSetText[1002,format['Max (%1)',_total_trades]];
		ctrlSetText[101,''];
		buttonSetaction[1,'tradeNum = (ctrlText 101)'];

		waitUntil{!dialog};

		if(isNil "tradeNum") exitWith {
			cutText["Cancelled trade","PLAIN DOWN"];
			call _finish_trade;
		};

		tradeNum = parseNumber(tradeNum);

		if(typeName tradeNum != "SCALAR" || tradeNum < 1 || tradeNum > _total_trades) exitWith {
			cutText["Incorrect value","PLAIN DOWN"];
			call _finish_trade;
		};
		_trade_num = tradeNum;
		tradeNum = nil;
	};

	_price = [(_sellprice*_trade_num)] call BIS_fnc_numberText;

	cutText["Starting trade,stand still to complete trade.","PLAIN DOWN"];

	if(isNil "_oldPosition") then {
		_oldPosition = position player;
	};

	_finished = false;

	sleep .5;

	if((position player) distance _oldPosition <= 0.1) then {
		_finished = true;
	};

	if(!_finished) exitWith { 
		r_interrupt = false;
		cutText["Cancelled trade" ,"PLAIN DOWN"];
	};

	if(_finished) then {

		_removed = ([player,_classname,_trade_num] call BIS_fnc_invRemove);

		if(_removed > 0) then {
			_player_money = player getVariable["cashMoney",0];	
			player setVariable["cashMoney",(_player_money + (_sellprice*_trade_num)),true];

			PVDZE_plr_Save = [player,(magazines player),true,true] ;
			publicVariableServer "PVDZE_plr_Save";

			cutText[format["Sold %1 %2 for %3 %4",_trade_num,_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
			systemChat format['[Trade] Sold %1 %2 for %2 %3',_trade_num,_display_name,_price,CurrencyAbbr];

			PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) sold a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
			publicVariableServer "PVDZE_log";

		} else {
			cutText[format["Something went wrong. Could not remove %1 from inventory",_classname],"PLAIN DOWN"];
		};

	};

};

DZE_ActionInProgress = false;