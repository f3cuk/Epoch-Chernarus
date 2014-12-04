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

	private ["_index","_trader_id","_activatingPlayer","_distance","_item_list"];

	TraderItemList = -1;
	_index = _this select 0;

	if (_index < 0 or TraderCurrentCatIndex == _index) exitWith {};
	TraderCurrentCatIndex = _index;

	_trader_id = TraderCatList select _index;
	_activatingPlayer = player;

	lbClear TraderDialogItemList;
	ctrlSetText [TraderDialogBuyPrice,""];
	ctrlSetText [TraderDialogSellPrice,""];

	lbAdd [TraderDialogItemList,"Loading items..."];

	PVDZE_plr_TradeMenuResult = missionNamespace getVariable (format["tcacheBuy_%1;",_trader_id]);

	if(isNil "PVDZE_plr_TradeMenuResult") then {
		PVDZE_plr_TradeMenu = [_activatingPlayer,_trader_id];
		publicVariableServer "PVDZE_plr_TradeMenu";
		waitUntil {!isNil "PVDZE_plr_TradeMenuResult"};
		if (count PVDZE_plr_TradeMenuResult > 0) then {
			missionNamespace setVariable [(format["tcacheBuy_%1;",_trader_id]),PVDZE_plr_TradeMenuResult];
		};
	};

	lbClear TraderDialogItemList;

	_item_list = [];
	{
		private ["_header","_item","_name","_type","_textPart","_qty","_buy","_bqty","_bname","_btype","_btextCurrency","_sell","_sqty","_sname","_stype","_stextCurrency","_order","_order","_afile","_File","_count","_bag","_bagclass","_index","_image"];
		
		_header 	= _x select 0;
		_item 		= _x select 1;
		_name 		= _item select 0;
		_type 		= _item select 1;
		
		call {
			if(_type == 1) exitWith { _type = "CfgMagazines"; }; 
			if(_type == 2) exitWith { _type = "CfgVehicles"; }; 
			if(_type == 3) exitWith { _type = "CfgWeapons"; };
		};

		_textPart =	getText(configFile >> _type >> _name >> "displayName");

		_qty 	= _x select 2;
		_buy 	= _x select 3;
		_bqty 	= _buy select 0;
		_btype 	= _buy select 1;

		call {
			if(_btype == 1) exitWith { _btype = "CfgMagazines"; }; 
			if(_btype == 2) exitWith { _btype = "CfgVehicles"; }; 
			if(_btype == 3) exitWith { _btype = "CfgWeapons"; };
		};

		_btextCurrency = "Coins" ;

		_sell 	= _x select 4;
		_sqty 	= _sell select 0;
		_stype 	= _sell select 1;

		call {
			if(_stype == 1) exitWith { _stype = "CfgMagazines"; }; 
			if(_stype == 2) exitWith { _stype = "CfgVehicles"; }; 
			if(_stype == 3) exitWith { _stype = "CfgWeapons"; };
		};

		_stextCurrency = "Coins";

		_order = _x select 5;
		_afile = _x select 7;
		
		_File = "custom\gold_coins\trading\" + _afile + ".sqf";
			
		_count = 0;
		if(_type == "CfgVehicles") then {
			if (_afile == "trade_backpacks") then {
				_bag = unitBackpack player;
				_bagclass = typeOf _bag;
				if(_name == _bagclass) then {
					_count = 1;
				};
			} else {
				if (isClass(configFile >> "CfgVehicles" >> _name)) then {
					_distance = dayz_sellDistance_vehicle;
					if (_name isKindOf "Air") then {
						_distance = dayz_sellDistance_air;
					};
					if (_name isKindOf "Ship") then {
						_distance = dayz_sellDistance_boat;
					};
					_count = {(typeOf _x) == _name} count (nearestObjects [player,[_name],_distance]);
				};
			};
		};

		if(_type == "CfgMagazines") then {
			_count = {_x == _name} count magazines player;
		};

		if(_type == "CfgWeapons") then {
			_count = {_x == _name} count weapons player;
		};
		
		if(_name in ["ItemBriefcase_Base","ItemSilvercase_Base"]) then {
			call {
				if(_name == "ItemBriefcase_Base") 	exitWith { _index = lbAdd [TraderDialogItemList,"EpochPack Premium"]; };
				if(_name == "ItemSilvercase_Base") 	exitWith { _index = lbAdd [TraderDialogItemList,"EpochPack Silver"]; };
			};
		} else {
			_index = lbAdd [TraderDialogItemList,format["%1 (%2)",_textPart,_name]];
		};

		if (_count > 0) then {
			lbSetColor [TraderDialogItemList,_index,[0,1,0,1]];
		};

		_image = getText(configFile >> _type >> _name >> "picture");
		lbSetPicture [TraderDialogItemList,_index,_image];

		_item_list set [count _item_list,[_name,_textPart,_bqty,"bname",_btextCurrency,_sqty,"sname",_stextCurrency,_header,_File]];

	} forEach PVDZE_plr_TradeMenuResult;

	TraderItemList = _item_list;
};

TraderDialogShowPrices = {

	private ["_index","_item","_buyprice","_sellprice"];

	_index = _this select 0;

	if (_index < 0) exitWith {};

	while {count TraderItemList < 1} do { sleep 1; };

	_item 	= TraderItemList select _index;

	_buyprice 	= [_item select 2] call BIS_fnc_numberText;
	_sellprice	= [_item select 5] call BIS_fnc_numberText;

	ctrlSetText [TraderDialogBuyPrice,format["%1 %2",_buyprice,_item select 4]];
	ctrlEnable [TraderDialogBuyBtn,true];
	ctrlSetText [TraderDialogSellPrice,format["%1 %2",_sellprice,_item select 7]];
};

TraderDialogBuy = {

	private ["_index","_item","_data"];

	_index = _this select 0;

	if (_index < 0) exitWith { 	cutText [(localize "str_epoch_player_6"),"PLAIN DOWN"]; };
		
	_item = TraderItemList select _index;
	_data = [_item select 0,_item select 3,1,_item select 2,"buy",_item select 4,_item select 1,_item select 8];
	[0,player,'',_data] execVM (_item select 9);

	TraderItemList = -1;
};

TraderDialogSell = {

	private ["_index","_item","_data"];

	_index = _this select 0;

	if (_index < 0) exitWith { cutText [(localize "str_epoch_player_6"),"PLAIN DOWN"]; };

	_item = TraderItemList select _index;
	_data = [_item select 6,_item select 0,_item select 5,1,"sell",_item select 1,_item select 7,_item select 8];
	[0,player,'',_data] execVM (_item select 9);

	TraderItemList = -1;
};