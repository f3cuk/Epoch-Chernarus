private["_cancel","_position","_reason","_classnametmp","_classname","_tmpbuilt","_dir","_location","_text","_limit","_isOk","_proceed","_counter","_dis","_sfx","_started","_finished","_animState","_isMedic","_num_removed","_lockable","_combinationDisplay","_combination_1","_combination_2","_combination_3","_combination_4","_combination","_combination_1_Display","_playerUID","_OwnerUID","_y_top","_y_bottom","_isAllowedUnderGround","_isPole","_restricted_area"];

_cancel 				= _this select 0;
_position 				= _this select 1;
_classnametmp 			= _this select 2;
_isAllowedUnderGround 	= _this select 3;
_text 					= _this select 4;
_isPole 				= _this select 5;
_lockable 				= _this select 6;
_dir 					= _this select 7;
_reason 				= _this select 8;

_playerUID = [player] call FNC_GetPlayerUID;

if(DZE_APlotforLife) then {
	_OwnerUID = _playerUID;
} else {
	_OwnerUID = dayz_characterID;
};

_isOk 		= true;
_proceed 	= false;
_counter 	= 0;
_location	= [0,0,0];

if(!DZE_BuildOnRoads) then {
	if(isOnRoad _position) then {
		_cancel = true;
		_reason = "Cannot build on a road.";
	};
};

if(!canbuild) then {
	_cancel = true;
	_reason = "Cannot build in a city";
};


isNearWater = {

	private["_result","_position","_radius"];

	_result 	= false;
	_position 	= _this select 0;
	_radius		= _this select 1;

	for "_i" from 0 to 359 step 45 do {
		_position = [(_position select 0) + (sin(_i)*_radius),(_position select 1) + (cos(_i)*_radius)];
		if(surfaceIsWater _position) exitWith {
			_result = true; 
		};
	};

	_result

};

_restricted_area = _position call {

	private["_result","_position","_y"];

	_result 	= false;
	_position 	= _this;
	_y_top 		= 4100;
	_y_bottom 	= 900;

	if(_position select 1 < _y_top && _position select 1 > _y_bottom) then {
		if(([_position,1000] call isNearWater) && !(surfaceIsWater _position)) then { _result = true; };
	};

	_result
};

if(_restricted_area) then { _cancel = true; _reason = "[Restricted] Cannot build in this area" };

if(!_cancel) then {

	_classname 	= _classnametmp;
	_tmpbuilt 	= createVehicle[_classname,_location,[],0,"CAN_COLLIDE"];
	_tmpbuilt setdir _dir;
	_location 	= _position;

	if((_isAllowedUnderGround == 0) && ((_location select 2) < 0)) then {
		_location set[2,0];
	};

	if(surfaceIsWater _location) then {
		_tmpbuilt setPosASL _location;
		_location = ASLtoATL _location;
	} else {
		_tmpbuilt setPosATL _location;
	};

	cutText[format[(localize "str_epoch_player_138"),_text],"PLAIN DOWN"];

	_limit = 3;

	if(DZE_StaticConstructionCount > 0) then {
		_limit = DZE_StaticConstructionCount;
	} else {
		if(isNumber (configFile >> "CfgVehicles" >> _classname >> "constructioncount")) then {
			_limit = getNumber(configFile >> "CfgVehicles" >> _classname >> "constructioncount");
		};
	};

	while {_isOk} do {

		[10,10] call dayz_HungerThirst;

		player playActionNow "Medic";

		_dis = 20;
		_sfx = "repair";

		[player,_sfx,0,false,_dis] call dayz_zombieSpeak;
		[player,_dis,true,([player] call FNC_GetPos)] spawn player_alertZombies;

		r_interrupt = false;
		r_doLoop = true;
		_started = false;
		_finished = false;

		while {r_doLoop} do {

			_animState = animationState player;
			_isMedic = ["medic",_animState] call fnc_inString;

			if(_isMedic) then {
				_started = true;
			};
			if(_started && !_isMedic) then {
				r_doLoop = false;
				_finished = true;
			};
			if(r_interrupt || (player getVariable["combattimeout",0] >= time)) then {
				r_doLoop = false;
			};
			if(DZE_cancelBuilding) exitWith {
				r_doLoop = false;
			};
			sleep 0.1;

		};

		r_doLoop = false;

		if(!_finished) exitWith {
			_isOk = false;
			_proceed = false;
		};

		if(_finished) then {
			_counter = _counter + 1;
		};

		cutText[format[(localize "str_epoch_player_139"),_text,_counter,_limit],"PLAIN DOWN"];

		if(_counter == _limit) exitWith {
			_isOk = false;
			_proceed = true;
		};

	};

	if(_proceed) then {

		_num_removed = ([player,DZE_buildItem] call BIS_fnc_invRemove);

		if(_num_removed == 1) then {

			cutText[format[localize "str_build_01",_text],"PLAIN DOWN"];

			if(_isPole) then {
				[] spawn player_plotPreview;
			};

			_tmpbuilt setVariable["OEMPos",_location,true];

			if(_lockable > 1) then {

				_combinationDisplay = "";

				call {

					if(_lockable == 2) exitWith {
						_combination_1 		= (floor(random 3)) + 100;
						_combination_2 		= floor(random 10);
						_combination_3 		= floor(random 10);
						_combination 		= format["%1%2%3",_combination_1,_combination_2,_combination_3];
						dayz_combination 	= _combination;

						if(_combination_1 == 100) then {
							_combination_1_Display = "Red";
						};
						if(_combination_1 == 101) then {
							_combination_1_Display = "Green";
						};
						if(_combination_1 == 102) then {
							_combination_1_Display = "Blue";
						};
						_combinationDisplay = format["%1%2%3",_combination_1_Display,_combination_2,_combination_3];
					};

					if(_lockable == 3) exitWith {
						_combination_1 		= floor(random 10);
						_combination_2 		= floor(random 10);
						_combination_3 		= floor(random 10);
						_combination 		= format["%1%2%3",_combination_1,_combination_2,_combination_3];
						dayz_combination 	= _combination;
						_combinationDisplay = _combination;
					};

					if(_lockable == 4) exitWith {
						_combination_1 = floor(random 10);
						_combination_2 = floor(random 10);
						_combination_3 = floor(random 10);
						_combination_4 = floor(random 10);
						_combination = format["%1%2%3%4",_combination_1,_combination_2,_combination_3,_combination_4];
						dayz_combination = _combination;
						_combinationDisplay = _combination;
					};
				};

				_tmpbuilt setVariable["CharacterID",_combination,true];
				_tmpbuilt setVariable["ownerPUID",_OwnerUID,true];

				PVDZE_obj_Publish = [_combination,_tmpbuilt,[_dir,_location,_playerUID],_classname];
				publicVariableServer "PVDZE_obj_Publish";

				cutText[format[(localize "str_epoch_player_140"),_combinationDisplay,_text],"PLAIN DOWN",5];

			} else {

				_tmpbuilt setVariable["CharacterID",dayz_characterID,true];
				_tmpbuilt setVariable["ownerPUID",_OwnerUID,true];

				if(_tmpbuilt isKindOf "Land_Fire_DZ") then {
					_tmpbuilt spawn player_fireMonitor;
				} else {

					PVDZE_obj_Publish = [dayz_characterID,_tmpbuilt,[_dir,_location,_playerUID],_classname];
					publicVariableServer "PVDZE_obj_Publish";
				};
			};

		} else {
			deleteVehicle _tmpbuilt;
			cutText[(localize "str_epoch_player_46") ,"PLAIN DOWN"];
		};

	} else {

		r_interrupt = false;

		if(vehicle player == player) then {
			[objNull,player,rSwitchMove,""] call RE;
			player playActionNow "stop";
		};

		deleteVehicle _tmpbuilt;

		cutText[(localize "str_epoch_player_46") ,"PLAIN DOWN"];
	};

} else {
	cutText[format[(localize "str_epoch_player_47"),_text,_reason],"PLAIN DOWN"];
};

DZE_ActionInProgress = false;