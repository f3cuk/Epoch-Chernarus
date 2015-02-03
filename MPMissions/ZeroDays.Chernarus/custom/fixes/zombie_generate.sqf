private["_dice","_position","_unitTypes","_radius","_method","_agent","_loot_count","_index","_weights","_loot","_array","_lootType","_favStance","_tooClose","_type","_rnd","_id","_doLoiter","_maxControlledZombies","_cantSee"];

_position 	= _this select 0;
_doLoiter 	= _this select 1;
_unitTypes 	= _this select 2;
_maxControlledZombies = round(dayz_maxLocalZombies);

_cantSee = {
	private["_isok","_deg","_eye","_ed","_xasl","_zPos","_fov","_safeDistance","_farDistance"];

	_isok = true;
	_zPos = +(_this select 0);

	if(count _zPos < 3) exitWith {
		diag_log format["%1::_cantSee illegal pos %2",__FILE__,_zPos];
		false
	};

	_zPos 			= ATLtoASL _zPos;
	_fov 			= _this select 1;
	_safeDistance 	= _this select 2;
	_farDistance 	= _this select 3;
	_zPos set[2,(_zPos select 2) + 1.7];

	{
		_xasl = getPosASL _x;
		if(_xasl distance _zPos < _farDistance) then {
			if(_xasl distance _zPos < _safeDistance) then {
				_isok = false;
			}
			else {
				_eye = eyePos _x;
				_ed = eyeDirection _x;
				_ed = (_ed select 0) atan2 (_ed select 1);
				_deg = [_xasl,_zPos] call BIS_fnc_dirTo;
				_deg = (_deg - _ed + 720) % 360;
				if(_deg > 180) then { _deg = _deg - 360; };
				if((abs(_deg) < _fov) && {(
						(!(terrainIntersectASL [_zPos,_eye])
						&& {(!(lineIntersects [_zPos,_eye]))})
					)}) then {
					_isok = false;
				};
			};
		};
		if(!_isok) exitWith {false};
	} count playableUnits;

	_isok
};

waitUntil {sleep .5; !isNil "inSafezone"};

if((dayz_spawnZombies < _maxControlledZombies) && (dayz_CurrentNearByZombies < dayz_maxNearByZombies) && (dayz_currentGlobalZombies < dayz_maxGlobalZeds) && !(inSafezone)) then {
	if([_position,dayz_cantseefov,10,dayz_cantseeDist] call _cantSee) then {

		_tooClose = {isPlayer _x} count (_position nearEntities ["CAManBase",30]) > 0;
		if(_tooClose) exitwith {};

		//Add zeds if unitTypes equals 0
		if(count _unitTypes == 0) then {
			if(DZE_MissionLootTable) then {
				_unitTypes = []+ getArray (missionConfigFile >> "CfgBuildingLoot" >> "Default" >> "zombieClass");
			} else {
				_unitTypes = []+ getArray (configFile >> "CfgBuildingLoot" >> "Default" >> "zombieClass");
			};
		};

		// lets create an agent
		_type 	= _unitTypes call BIS_fnc_selectRandom;
		_radius = 5;
		_method = "NONE";
		if(_doLoiter) then {
			_radius = 40;
			_method = "CAN_COLLIDE";
		};

		//Check if point is in water
		if(surfaceIsWater _position) exitwith {  };

		_agent = createAgent [_type,_position,[],_radius,_method];
		sleep 0.001;

		//add to global counter
		dayz_spawnZombies = dayz_spawnZombies + 1;

		//Add some loot
		_loot 	= "";
		_array 	= [];
		_rnd 	= random 1;

		if(_rnd < 0.2) then {
			_lootType = configFile >> "CfgVehicles" >> _type >> "zombieLoot";
			if(isText _lootType) then {
				_array = [];
				{
					_array set[count _array,_x select 0]
				} forEach getArray (configFile >> "cfgLoot" >> getText(_lootType));
				if(count _array > 0) then {
					_index = dayz_CLBase find getText(_lootType);
					_weights = dayz_CLChances select _index;
					_loot = _array select (_weights select (floor(random (count _weights))));
					if(!isNil "_array") then {
						_loot_count =	getNumber(configFile >> "CfgMagazines" >> _loot >> "count");
						if(_loot_count > 1) then {
							_agent addMagazine [_loot,ceil(random _loot_count)];
						} else {
							_agent addMagazine _loot;
						};
					};
				};
			};
		};

		_dice = floor(random 100);

		call {
			if(_dice > 50)	exitWith { _agent setVariable["cashMoney",(floor(random 10) + 1)]; };
			if(_dice < 5)	exitWith { _agent setVariable["cashMoney",(floor(random 200) + 1)]; };
			if(_dice < 25)	exitWith { _agent setVariable["cashMoney",(floor(random 50) + 1)]; };
			if(_dice < 50)	exitWith { _agent setVariable["cashMoney",0]; };
		};
		_agent setVariable["agentObject",_agent];

		if(!isNull _agent) then {
			_agent setDir random 360;
			sleep 0.001;

			_position = [_agent] call FNC_GetPos;

			_favStance = (
				switch ceil(random(3^0.5)^2) do {
					case 2: {"Middle"}; // Kneel
					default {"UP"} // stand-up
				}
			);
			_agent setUnitPos _favStance;

			_agent setVariable["stance",_favStance];
			_agent setVariable["BaseLocation",_position];
			_agent setVariable["doLoiter",true];
			_agent setVariable["myDest",_position];
			_agent setVariable["newDest",_position];
			[_agent,_position] call zombie_loiter;
		};

		PVDZE_Server_Simulation = [_agent,false];
		publicVariableServer "PVDZE_Server_Simulation";

		_id = [_position,_agent] execFSM "\z\AddOns\dayz_code\system\zombie_agent.fsm";
	};
};