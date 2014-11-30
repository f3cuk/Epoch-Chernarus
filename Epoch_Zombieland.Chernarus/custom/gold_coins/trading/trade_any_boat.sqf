private ["_oldPosition","_veh","_location","_isOk","_part_out","_part_in","_qty_out","_qty_in","_qty","_buy_o_sell","_obj","_objectID","_objectUID","_bos","_finished","_dir","_helipad","_removed","_keyColor","_keyNumber","_keySelected","_isKeyOK","_config","_okToSell","_needed","_activatingPlayer","_textPartIn","_textPartOut","_traderID","_price","_object_name","_curr_new","_newM","_myMoney"];

if(DZE_ActionInProgress) exitWith { cutText [(localize "str_epoch_player_103"), "PLAIN DOWN"]; };

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
	_obj = nearestObjects [(getPosATL player), [_part_in], dayz_sellDistance_boat];
	_qty = count _obj;
	_bos = 1;
};


if (_qty >= _qty_in) then {

	cutText [(localize "str_epoch_player_105"), "PLAIN DOWN"];
	 
	[1,1] call dayz_HungerThirst;

	// # F3 FAST TRADING

		if(isNil "_oldPosition") then {
			_oldPosition = position player;
		};

		_finished = false;

		sleep .5;

		if ((position player) distance _oldPosition <= 0.3) then {
			_finished = true;
		};

		if (!_finished) exitWith { 
			r_interrupt = false;
			cutText ["Cancelled trade" , "PLAIN DOWN"];
		};
	
	// # F3 FAST TRADING

	if (_finished) then {

		if(_buy_o_sell == "buy") then {
			_qty = player getVariable ["cashMoney",0]; // get your money variable	
		} else {
			_obj = nearestObjects [(getPosATL player), [_part_in], dayz_sellDistance_boat];
			_qty = count _obj;
		};

		if (_qty >= _qty_in) then {

			if (isNil "_obj") then { _obj = "Unknown Vehicle" };
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

					_keyColor 		= ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
					_keyNumber 		= (floor(random 2500)) + 1;
					_keySelected 	= format[("ItemKey%1%2"),_keyColor,_keyNumber];
					_isKeyOK 		= isClass(configFile >> "CfgWeapons" >> _keySelected);
					
					_config 		= _keySelected;
					_isOk 			= [player,_config] call BIS_fnc_invAdd;

					waitUntil {!isNil "_isOk"};
					
					if (_isOk and _isKeyOK) then {
					
						_curr_new = _qty - _qty_in;
					
						player setVariable ["cashMoney",_curr_new,true];
						
						_newM 		= player getVariable ["cashMoney",0];
						_removed 	= _qty - _newM;
															
						if(_removed == _qty_in) then {
						
							_price 			= [_qty_in] call BIS_fnc_numberText;
							_object_name 	= getText (configFile >> "CfgVehicles" >> _part_out >> "displayName");
						
							systemChat format ['Bought a %1 for %2 %3',_object_name,_price,CurrencyName];
							
							_dir = round(random 360);

							_helipad = nearestObjects [player, ["HeliHCivil","HeliHempty"], 100];
							if(count _helipad > 0) then {
								_location = (getPosATL (_helipad select 0));
							} else {
								_location = [(position player),0,20,1,2,2000,0] call BIS_fnc_findSafePos;
							};
	
							_veh = createVehicle ["Sign_arrow_down_large_EP1", _location, [], 0, "CAN_COLLIDE"];

							_location = (getPosATL _veh);
					
							PVDZE_veh_Publish2 = [_veh,[_dir,_location],_part_out,false,_keySelected,_activatingPlayer];

							publicVariableServer  "PVDZE_veh_Publish2";

							player reveal _veh;

							cutText [format[("Bought %3 for %1 %2, key added to toolbelt."),_qty_in,_textPartIn,_textPartOut], "PLAIN DOWN"];
						} else {
							player removeMagazine _keySelected;
						};
					} else {
						cutText [(localize "str_epoch_player_107"), "PLAIN DOWN"];
					};
				} else {
					
					_obj = _obj select 0;

					_okToSell = true;
					if(!local _obj) then {
						_okToSell = false;
					};

					if(_okToSell and !isNull _obj and alive _obj) then {

						_myMoney = player getVariable ["cashMoney",0];
						_myMoney = _myMoney + _qty_out;
						player setVariable ["cashMoney", _myMoney , true];

						_objectID 	= _obj getVariable ["ObjectID","0"];
						_objectUID	= _obj getVariable ["ObjectUID","0"];

						PVDZE_obj_Delete = [_objectID,_objectUID,_activatingPlayer];
						publicVariableServer "PVDZE_obj_Delete";

						deleteVehicle _obj;

						cutText [format[(localize "str_epoch_player_181"),_qty_in,_textPartIn,_qty_out,_textPartOut], "PLAIN DOWN"];
					} else {
						cutText [(localize "str_epoch_player_245"), "PLAIN DOWN"];
					};
				};
	
				{player removeAction _x} forEach s_player_parts;s_player_parts = [];
				s_player_parts_crtl = -1;

			} else {
				cutText [format[(localize "str_epoch_player_183"),_textPartOut] , "PLAIN DOWN"];
			};
			dayzTradeResult = nil;
		};
	};

} else {
	_needed =  _qty_in - _qty;
	if(_buy_o_sell == "buy") then {
		cutText [format["You need %1 %2",_needed,_textPartIn] , "PLAIN DOWN"]; // edited so it says, You need 5000 coins or you need 1 engine.
	} else {
		cutText [format[(localize "str_epoch_player_185"),_textPartIn] , "PLAIN DOWN"];
	};
};

DZE_ActionInProgress = false;