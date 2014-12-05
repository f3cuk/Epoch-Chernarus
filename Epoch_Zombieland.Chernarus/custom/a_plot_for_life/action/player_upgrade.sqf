private["_location","_dir","_classname","_missing","_text","_proceed","_num_removed","_object","_missingQty","_itemIn","_countIn","_qty","_removed","_removed_total","_tobe_removed_total","_objectID","_temp_removed_array","_textMissing","_newclassname","_requirements","_obj","_upgrade","_lockable","_combination_1","_combination_2","_combination_3","_combination","_objectCharacterID","_canBuildOnPlot","_friendlies","_nearestPole","_ownerID","_distance","_needText","_findNearestPoles","_findNearestPole","_IsNearPlot","_playerUID"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_52") ,"PLAIN DOWN"]; };
DZE_ActionInProgress = true;

player removeAction s_player_upgrade_build;
s_player_upgrade_build = 1;

_distance = (DZE_PlotPole select 1/2);
_needText = localize "str_epoch_player_246";

_findNearestPoles	= nearestObjects[(vehicle player),["Plastic_Pole_EP1_DZ"],_distance];
_findNearestPole	= [];

{
	if(alive _x) then {
		_findNearestPole set[(count _findNearestPole),_x];
	};
} count _findNearestPoles;

_IsNearPlot = count (_findNearestPole);
_canBuildOnPlot = false;

if(_IsNearPlot == 0) then {
	_canBuildOnPlot = true;
} else {

	_nearestPole	= _findNearestPole select 0;
	_ownerID		= _nearestPole getVariable["ownerPUID","0"];

	if(DZE_APlotforLife) then {
		_playerUID = [player] call FNC_GetPlayerUID;
	} else {
		_playerUID = dayz_characterID;
	};

	if(_playerUID == _ownerID) then {
		_canBuildOnPlot = true;		
	} else {
		_friendlies = player getVariable["friendlyTo",[]];
		if(_ownerID in _friendlies) then {
			_canBuildOnPlot = true;
		};
	};
};

if(!_canBuildOnPlot) exitWith { 
	DZE_ActionInProgress = false;
	cutText[format[(localize "str_epoch_player_157"),_needText,_distance],"PLAIN DOWN"];
};

_obj = _this select 3;
_objectID = _obj getVariable["ObjectID","0"];
_objectUID = _obj getVariable["ObjectUID","0"];

if(_objectID == "0") exitWith {
	DZE_ActionInProgress = false;
	s_player_upgrade_build = -1;
	cutText[(localize "str_epoch_player_50"),"PLAIN DOWN"];
};

_classname	= typeOf _obj;
_text		= getText (configFile >> "CfgVehicles" >> _classname >> "displayName");
_upgrade	= getArray (configFile >> "CfgVehicles" >> _classname >> "upgradeBuilding");

if((count _upgrade) > 0) then {

	_newclassname = _upgrade select 0;

	_lockable = 0;
	if(isNumber (configFile >> "CfgVehicles" >> _newclassname >> "lockable")) then {
		_lockable = getNumber(configFile >> "CfgVehicles" >> _newclassname >> "lockable");
	};

	_requirements = _upgrade select 1;

	_missingQty = 0;
	_missing = "";

	_proceed = true;
	{
		_itemIn = _x select 0;
		_countIn = _x select 1;
		_qty = { (_x == _itemIn) || (configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn) } count magazines player;
		if(_qty < _countIn) exitWith { _missing = _itemIn; _missingQty = (_countIn - _qty); _proceed = false; };
	} forEach _requirements;

	if(_proceed) then {
		[1,1] call dayz_HungerThirst;
		player playActionNow "Medic";
		[player,20,true,([player] call FNC_GetPos)] spawn player_alertZombies;

		_temp_removed_array = [];
		_removed_total = 0;
		_tobe_removed_total = 0;

		{
			_removed = 0;
			_itemIn = _x select 0;
			_countIn = _x select 1;
			_tobe_removed_total = _tobe_removed_total + _countIn;

			{					
				if( (_removed < _countIn) && ((_x == _itemIn) || configName(inheritsFrom(configFile >> "cfgMagazines" >> _x)) == _itemIn)) then {
					_num_removed = ([player,_x] call BIS_fnc_invRemove);
					_removed = _removed + _num_removed;
					_removed_total = _removed_total + _num_removed;
					if(_num_removed >= 1) then {
						_temp_removed_array set[count _temp_removed_array,_x];
					};
				};
			} count magazines player;

		} forEach _requirements;

		if(_tobe_removed_total == _removed_total) then {
			_location			= _obj getVariable["OEMPos",([_obj] call FNC_GetPos)];
			_dir				= getDir _obj;
			_objectCharacterID	= _obj getVariable["CharacterID","0"];
			_ownerID			= _obj getVariable["ownerPUID","0"];
			_classname			= _newclassname;

			_object = createVehicle[_classname,[0,0,0],[],0,"CAN_COLLIDE"];
			_object setDir _dir;
			_object setPosATL _location;
			_object setVariable["ownerPUID",_ownerID,true];

			if(_lockable == 3) then {
				_combination_1 = floor(random 10);
				_combination_2 = floor(random 10);
				_combination_3 = floor(random 10);
				_combination = format["%1%2%3",_combination_1,_combination_2,_combination_3];

				_objectCharacterID = _combination;

				cutText[format[(localize "str_epoch_player_158"),_combination,_text],"PLAIN DOWN",5];
			} else {	
				cutText[format[(localize "str_epoch_player_159"),_text],"PLAIN DOWN",5];
			};

			if(parseNumber(_objectID) in spawnedIds) then {
				_obj = _objectID;
			};

			PVDZE_obj_Swap = [_objectCharacterID,_object,[_dir,_location,_ownerID],_classname,_obj,player];
			publicVariableServer "PVDZE_obj_Swap";

			player reveal _object;
			_object = nil;
		} else {
			{player addMagazine _x;} count _temp_removed_array;
			cutText[format[(localize "str_epoch_player_145"),_removed_total,_tobe_removed_total],"PLAIN DOWN"];
		};
	} else {
		_textMissing = getText(configFile >> "CfgMagazines" >> _missing >> "displayName");
		cutText[format[(localize "str_epoch_player_146"),_missingQty,_textMissing],"PLAIN DOWN"];
	};
} else {
	cutText[(localize "str_epoch_player_82"),"PLAIN DOWN"];
};

DZE_ActionInProgress = false;
s_player_upgrade_build = -1;