TraderDialogCatList 	= 12000;
TraderDialogItemList 	= 12001;
TraderDialogBuyPrice 	= 12002;
TraderDialogSellPrice 	= 12003;
TraderDialogBuyBtn 		= 12004;
TraderDialogSellBtn 	= 12005;
TraderDialogCurrency 	= 12006;

TraderCurrentCatIndex 	= -1;
TraderCatList 			= -1;
TraderItemList 			= -1;

TraderDialogLoadItemList = {

	private["_index","_trader_id","_item_list"];

	ctrlEnable [TraderDialogBuyBtn,false];
	ctrlEnable [TraderDialogSellBtn,false];

	TraderItemList = -1;
	_index = _this select 0;

	if(_index < 0 or TraderCurrentCatIndex == _index) exitWith {};
	TraderCurrentCatIndex = _index;

	_trader_id = TraderCatList select _index;

	lbClear TraderDialogItemList;
	ctrlSetText[TraderDialogBuyPrice,""];
	ctrlSetText[TraderDialogSellPrice,""];

	lbAdd[TraderDialogItemList,"Loading items..."];

	lbClear TraderDialogItemList;

	_item_list = [];
	
	{
		private["_type","_count","_bag","_bagclass","_distance","_classname","_buyprice","_sellprice","_trade_file","_trade_path","_btextCurrency","_stextCurrency","_display_name","_image"];

		_classname 	= _x select 0;
		_type 		= _x select 1;
		_buyprice	= _x select 2;
		_sellprice	= _x select 3;
		_trade_file	= _x select 4;
		_trade_path	= "custom\gold_coins\trading\" + _trade_file + ".sqf";

		_btextCurrency = "Coins";
		_stextCurrency = "Coins";

		call {
			if(_type == 1) exitWith { _type = "CfgMagazines"; }; 
			if(_type == 2) exitWith { _type = "CfgVehicles"; }; 
			if(_type == 3) exitWith { _type = "CfgWeapons"; };
		};

		_display_name =	getText(configFile >> _type >> _classname >> "displayName");
		_count = 0;

		if(_type == "CfgVehicles") then {
			if(_trade_file == "trade_backpacks") then {
				_bag = unitBackpack player;
				_bagclass = typeOf _bag;
				if(_classname == _bagclass) then {
					_count = 1;
				};
			} else {
				if(isClass(configFile >> "CfgVehicles" >> _classname)) then {
					_distance = dayz_sellDistance_vehicle;
					if(_classname isKindOf "Air") then {
						_distance = dayz_sellDistance_air;
					};
					if(_classname isKindOf "Ship") then {
						_distance = dayz_sellDistance_boat;
					};
					_count = {(typeOf _x) == _classname} count (nearestObjects[player,[_classname],_distance]);
				};
			};
		};

		if(_type == "CfgMagazines") then {
			_count = {_x == _classname} count magazines player;
		};

		if(_type == "CfgWeapons") then {
			_count = {_x == _classname} count weapons player;
		};

		if(_classname in ["ItemBriefcase_Base","ItemSilvercase_Base"]) then {
			call {
				if(_classname == "ItemBriefcase_Base")	exitWith { _index = lbAdd[TraderDialogItemList,"EpochPack Premium"]; };
				if(_classname == "ItemSilvercase_Base")	exitWith { _index = lbAdd[TraderDialogItemList,"EpochPack Silver"]; };
			};
		} else {
			_index = lbAdd[TraderDialogItemList,format["%1 - (Buy: %2 - Sell: %3)",_display_name,([_buyprice] call BIS_fnc_numberText),([_sellprice] call BIS_fnc_numberText)]];
		};

		if(_count > 0) then {
			lbSetColor [TraderDialogItemList,_index,[0,1,0,1]];
		};

		_image = getText(configFile >> _type >> _classname >> "picture");
		lbSetPicture [TraderDialogItemList,_index,_image];

		_item_list set[count _item_list,[
			_classname,
			_display_name,
			_buyprice,
			_sellprice,
			_trade_path,
			(_count > 0)
		]];

	} forEach (trader_data select _trader_id);

	TraderItemList = _item_list;
};

TraderDialogShowPrices = {

	private["_index","_item","_buyprice","_sellprice"];

	_index = _this select 0;

	if(_index < 0) exitWith {};

	while {count TraderItemList < 1} do { sleep 1; };

	_item = TraderItemList select _index;

	_buyprice 	= [_item select 2] call BIS_fnc_numberText;
	_sellprice	= [_item select 3] call BIS_fnc_numberText;

	ctrlSetText[TraderDialogBuyPrice,format["%1 %2",_buyprice,CurrencyAbbr]];
	ctrlSetText[TraderDialogSellPrice,format["%1 %2",_sellprice,CurrencyAbbr]];

	if(player getVariable["cashMoney",0] >= (_item select 2)) then {
		ctrlEnable [TraderDialogBuyBtn,true];
	} else {
		ctrlEnable [TraderDialogBuyBtn,false];
	};

	if(_item select 5) then {
		ctrlEnable [TraderDialogSellBtn,true];
	} else {
		ctrlEnable [TraderDialogSellBtn,false];
	};

};

TraderDialogBuy = {

	private["_index","_item","_data"];

	_index = _this select 0;

	if(_index < 0) exitWith { cutText[(localize "str_epoch_player_6"),"PLAIN DOWN"]; };

	_item = TraderItemList select _index;
	_data = [
		"buy",
		_item select 0,
		_item select 1,
		_item select 2,
		_item select 3
	];

	[0,player,'',_data] execVM (_item select 4);

	TraderItemList = -1;
};

TraderDialogSell = {

	private["_index","_item","_data"];

	_index = _this select 0;

	if(_index < 0) exitWith { cutText[(localize "str_epoch_player_6"),"PLAIN DOWN"]; };

	_item = TraderItemList select _index;
	_data = [
		"sell",
		_item select 0,
		_item select 1,
		_item select 2,
		_item select 3
	];

	[0,player,'',_data] execVM (_item select 4);

	TraderItemList = -1;
};