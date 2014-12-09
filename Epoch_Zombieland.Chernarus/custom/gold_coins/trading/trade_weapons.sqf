private ["_abort","_secondaryWeapon","_msg","_has_required","_oldPosition","_finished","_classname","_newM","_removed","_player_money","_trade_type","_display_name","_buyprice","_sellprice","_config","_configName","_wepType","_price"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_103") ,"PLAIN DOWN"]; };

DZE_ActionInProgress = true;

_trade_type		= (_this select 3) select 0;
_classname 		= (_this select 3) select 1;
_display_name 	= (_this select 3) select 2;
_buyprice 		= (_this select 3) select 3;
_sellprice		= (_this select 3) select 4;
_player_money	= player getVariable["cashMoney",0];

_config 		= (configFile >> "CfgWeapons" >> _classname);
_configName 	= configName(_config);
_wepType 		= getNumber(_config >> "Type");

if(_trade_type == "buy") then {
	_msg = "Drop or sell your current weapon before you can buy a new one";

	call {
		if(_wepType == 1) exitWith { // primary
			_abort = ((primaryWeapon player) != "");
		};
		if(_wepType == 2) exitWith { // secondary
			_secondaryWeapon = "";
			{
				if((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith {
						_secondaryWeapon = _x;
				};
			} count (weapons player);
			_abort = (_secondaryWeapon != "");
		};
		if(_wepType == 131072) exitWith { // toolbelt
			_abort = (_configName in (weapons player)); 
			_msg = "Drop or sell your current toolbelt item before you can buy a new one.";
		};
		if(_wepType == 4096) exitWith { //binoculars
			_abort = (_configName in (weapons player)); 
			_msg = "Drop or sell your current toolbelt item before you can buy a new one.";
		};
	};

	if(!_abort) then {
		_has_required = (_player_money >= _buyprice);
		_msg = "You do not have enough money to buy this weapon";
	} else {
		_has_required = false;
	};

} else {
	_msg = "Need the weapon in your hands before you can sell it";
	if(_wepType in [131072,4096]) then {
		_msg = "Need the item on your toolbelt before you can sell it.";
	};
	_has_required = ((_configName in (weapons player)));
};

if(_has_required) then {

	cutText[(localize "str_epoch_player_105"),"PLAIN DOWN"];
	 
	[1,1] call dayz_HungerThirst;

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

	if(_finished) then {

		if(isNil "_classname") then { _classname = "Unknown Weapon/Magazine" };
		if(isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };

		_player_money = player getVariable["cashMoney",0];

		if(_trade_type == "buy") then {
			_price = [_buyprice] call BIS_fnc_numberText;

			if(_player_money >= _buyprice) then {

				player setVariable["cashMoney",(_player_money - _buyprice),true];

				_newM = player getVariable["cashMoney",0];
				_removed = _player_money - _newM;

				if(_removed == _buyprice) then {
					player addWeapon _classname;
				};

				cutText[format["Bought a %1 for %2 %3",_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
				systemChat format['[Trade] Bought a %1 for %2 %3',_display_name,_price,CurrencyAbbr];

				PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
				publicVariableServer "PVDZE_log";

			} else {
				cutText["Cannot buy weapon, not enough money","PLAIN DOWN"];
			};

		} else {
			_price		= [_sellprice] call BIS_fnc_numberText;
			_removed	= ([player,_classname,1] call BIS_fnc_invRemove);

			if(_removed == 1) then {
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

		s_player_parts		= [];
		s_player_parts_crtl	= -1;
	};

} else {
	cutText[format["%1",_msg],"PLAIN DOWN"];

};

DZE_ActionInProgress = false;