private ["_has_required","_obj","_oldPosition","_finished","_location","_price","_dir","_helipad","_veh","_newM","_removed","_keyColor","_keyNumber","_keySelected","_isKeyOK","_isOk","_damage","_tireDmg","_tires","_okToSell","_objectID","_objectUID","_hitpoints","_player_money","_trade_type","_classname","_display_name","_buyprice","_sellprice"];

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
	if(_classname isKindOf "AIR") then {
		_obj = nearestObjects[([player] call FNC_GetPos),[_classname],dayz_sellDistance_air];
	} else {
		_obj = nearestObjects[([player] call FNC_GetPos),[_classname],dayz_sellDistance_vehicle];
	};
	_has_required = (count _obj > 0);
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
		r_interrupt = false;
		cutText["Trade cancelled","PLAIN DOWN"];
	};

	if(_finished) then {

		_player_money = player getVariable["cashMoney",0];

		if(isNil "inTraderCity") then { inTraderCity = "Unknown Trader City" };

		if(_trade_type == "buy") then {
			_price = [_buyprice] call BIS_fnc_numberText;

			if(_player_money >= _buyprice) then {

				_keyColor		= ["Green","Red","Blue","Yellow","Black"] call BIS_fnc_selectRandom;
				_keyNumber		= (floor(random 2500)) + 1;
				_keySelected	= format[("ItemKey%1%2"),_keyColor,_keyNumber];	
				_isKeyOK		= isClass(configFile >> "CfgWeapons" >> _keySelected);
				_isOk			= [player,_keySelected] call BIS_fnc_invAdd;

				waitUntil {!isNil "_isOk"};

				if(_isOk && _isKeyOK) then {

					player setVariable["cashMoney",(_player_money - _buyprice),true];

					_newM		= player getVariable["cashMoney",0];
					_removed	= _player_money - _newM;

					if(_removed == _buyprice) then {

						_dir		= round(random 360);
						_helipad	= nearestObjects[player,["HeliHCivil","HeliHempty"],100];

						if(count _helipad > 0) then {
							_location = (getPosATL (_helipad select 0));
						} else {
							_location = [(position player),0,20,1,0,2000,0] call BIS_fnc_findSafePos;
						};

						_veh		= createVehicle["Sign_arrow_down_large_EP1",_location,[],0,"CAN_COLLIDE"];
						_location	= ([_veh] call FNC_GetPos);

						PVDZE_veh_Publish2 = [_veh,[_dir,_location],_classname,false,_keySelected,player];
						publicVariableServer "PVDZE_veh_Publish2";

						cutText[format["Bought a %1 for %2 %3, key added to toolbelt",_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
						systemChat format['[Trade] Bought a %1 for %2 %3',_display_name,_price,CurrencyAbbr];

						PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) bought a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
						publicVariableServer "PVDZE_log";

					} else {
						player removeMagazine _keySelected;
					};
				} else {
					cutText[(localize "str_epoch_player_107"),"PLAIN DOWN"];
				};

			} else {
				cutText["Cannot buy vehicle, not enough money","PLAIN DOWN"];
			};

		} else {
			_price = [_sellprice] call BIS_fnc_numberText;

			if(_classname isKindOf "AIR") then {
				_obj = nearestObjects[([player] call FNC_GetPos),[_classname],dayz_sellDistance_air];
			} else {
				_obj = nearestObjects[([player] call FNC_GetPos),[_classname],dayz_sellDistance_vehicle];
			};

			_obj = _obj select 0;

			_hitpoints	= _obj call vehicle_getHitpoints;
			_okToSell	= true;
			_tires		= 0; 
			_tireDmg	= 0;
			_damage		= 0;

			{					
				if(["Wheel",_x,false] call fnc_inString) then {		
					_damage		= [_obj,_x] call object_getHit;
					_tireDmg	= _tireDmg + _damage;
					_tires		= _tires + 1;
				};
			} count _hitpoints;

			if(_tireDmg > 0 && _tires > 0) then {
				if((_tireDmg / _tires) > 0.75) then {
					_okToSell = false;
				};
			};

			if(local _obj && !isNull _obj && alive _obj) then {

				if(_okToSell) then {

					player setVariable["cashMoney",(_player_money + _sellprice),true];

					_objectID 	= _obj getVariable["ObjectID","0"];
					_objectUID	= _obj getVariable["ObjectUID","0"];

					PVDZE_obj_Delete = [_objectID,_objectUID,player];
					publicVariableServer "PVDZE_obj_Delete";

					deleteVehicle _obj; 

					cutText[format["Sold a %1 for %2 %3",_display_name,_price,CurrencyAbbr],"PLAIN DOWN"];
					systemChat format['[Trade] Sold a %1 for %2 %3',_display_name,_price,CurrencyAbbr];

					PVDZE_log = [format["EPOCH SERVERTRADE: Player: %1 (%2) sold a %3 in/at %4 for %5 %6",(name player),(getPlayerUID player),_classname,inTraderCity,_price,CurrencyAbbr]];
					publicVariableServer "PVDZE_log";

				} else {
					cutText[format[(localize "str_epoch_player_182"),CurrencyAbbr] ,"PLAIN DOWN"];
				};
			} else {
				cutText[(localize "str_epoch_player_245"),"PLAIN DOWN"];
			};

		};

		{
			player removeAction _x
		} count s_player_parts;
		s_player_parts = [];
		s_player_parts_crtl = -1;

	};

} else {

	if(_trade_type == "buy") then {
		cutText["Cannot buy vehicle, not enough money","PLAIN DOWN"];
	} else {
		cutText["Cannot sell vehicle, vehicle not found","PLAIN DOWN"];
	};

};

DZE_ActionInProgress = false;