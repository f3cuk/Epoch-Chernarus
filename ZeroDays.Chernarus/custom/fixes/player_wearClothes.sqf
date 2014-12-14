private["_item","_onLadder","_hasclothesitem","_config","_text","_myModel","_itemNew","_currentSex","_newSex","_model"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_83") ,"PLAIN DOWN"] };

DZE_ActionInProgress = true;

_item = _this;
call gear_ui_init;

_onLadder =	(getNumber (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState player) >> "onLadder")) == 1;
if(_onLadder) exitWith {DZE_ActionInProgress = false; cutText[(localize "str_player_21") ,"PLAIN DOWN"]};

_hasclothesitem 	= _this in magazines player;
_config 			= configFile >> "CfgMagazines";
_text 				= getText (_config >> _item >> "displayName");

if(!_hasclothesitem) exitWith { DZE_ActionInProgress = false; cutText[format[(localize "str_player_31"),_text,"wear"] ,"PLAIN DOWN"]};

if(vehicle player != player) exitWith { DZE_ActionInProgress = false; cutText[(localize "str_epoch_player_85"),"PLAIN DOWN"]};

if("CSGAS" in (magazines player)) exitWith { DZE_ActionInProgress = false; cutText[(localize "STR_EPOCH_ACTIONS_10"),"PLAIN DOWN"] };

_myModel 			= (typeOf player);
_itemNew 			= "Skin_" + _myModel;

if( (isClass(_config >> _itemNew)) ) then {
	if( (isClass(_config >> _item)) ) then {

		_currentSex = getText (configFile >> "CfgSurvival" >> "Skins" >> _itemNew >> "sex");
		_newSex = getText (configFile >> "CfgSurvival" >> "Skins" >> _item >> "sex");

		if(_currentSex == _newSex) then {
			// Get model name from config
			_model = getText (configFile >> "CfgSurvival" >> "Skins" >> _item >> "playerModel");
			if(_model != _myModel) then {
				if(([player,_item] call BIS_fnc_invRemove) == 1) then {
					player addMagazine _itemNew;
					player setVariable["inTransit",true,true];
					[] spawn {
						sleep 10;
						if((player getVariable["inTransit",false])) then {
							player enableSimulation false;
							cutText["Something went wrong with changing clothes. Auto moving you to the lobby in 5 seconds. Please relog.","BLACK"];
							PVDZE_log = [format["[CHANGE CLOTHES] Player %1 (%2) was kicked to the lobby because changing clothes got stuck.",(name player),(getPlayerUID player)]];
							publicVariableServer "PVDZE_log";
							sleep 5;
							endMission "END1";
						};
					};
					[dayz_playerUID,dayz_characterID,_model] call player_humanityMorph;
					player setVariable["inTransit",false,true];
				};
			};
		} else {
			cutText[(localize "str_epoch_player_86"),"PLAIN DOWN"];
		};
	};
};

DZE_ActionInProgress = false;