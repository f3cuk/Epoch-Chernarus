private["_result","_pos","_wsDone","_dir","_isOK","_countr","_objWpnTypes","_objWpnQty","_dam","_selection","_totalvehicles","_object","_idKey","_type","_ownerID","_worldspace","_inventory","_hitPoints","_fuel","_damage","_key","_vehLimit","_hiveResponse","_objectCount","_codeCount","_data","_status","_traderid","_id","_lockable","_debugMarkerPosition","_vehicle_0","_hiveLoaded","_skip","_ownerPUID","_objects"];

dayz_versionNo		= getText(configFile >> "CfgMods" >> "DayZ" >> "version");
dayz_hiveVersionNo	= getNumber(configFile >> "CfgMods" >> "DayZ" >> "hiveVersion");

_hiveLoaded	= false;

waitUntil{initialized};

if(isServer && isNil "sm_done") then {

	serverVehicleCounter	= [];
	_hiveResponse			= [];

	diag_log format["HIVE: trying to get objects for instance %1",dayZ_instance];

	_key = format["CHILD:302:%1:",dayZ_instance];
	_hiveResponse = _key call server_hiveReadWrite;
	_objectCount = _hiveResponse select 1;

	if(!isNil "_hiveResponse" && typeName _hiveResponse == "ARRAY" && typeName _objectCount == "SCALAR") then {
		diag_log format["HIVE: Found %1 objects to load",(_objectCount)];
		_hiveLoaded = true;
	};

	if(!_hiveLoaded) exitWith {
		diag_log format["HIVE: Error could not load hive (DEBUG: %1)",_hiveResponse];
	};

	epochObjects	= [];
	deleteObjects	= [];
	localIds		= [];
	serverObjects	= [];

	if((_hiveResponse select 0) == "ObjectStreamStart") then {

		profileNamespace setVariable["SUPERKEY",(_hiveResponse select 2)];

		diag_log format["HIVE: SUPERKEY set (%1), retrieving and spawning (%2) objects",(_hiveResponse select 2),_objectCount];

		_key = format["CHILD:302:%1:",dayZ_instance];

		_totalvehicles = 0;

		for "_i" from 1 to _objectCount do {
			_hiveResponse = _key call server_hiveReadWriteLarge;

			_idKey		= _hiveResponse select 1;
			_type		= _hiveResponse select 2;
			_ownerID	= _hiveResponse select 3;
			_worldspace	= _hiveResponse select 4;
			_inventory	= _hiveResponse select 5;
			_hitPoints	= _hiveResponse select 6;
			_fuel		= _hiveResponse select 7;
			_damage		= _hiveResponse select 8;
			_dir		= 0;
			_pos		= [0,0,0];
			_wsDone		= false;
			_skip		= false;

			if(_type in immune_objects) then {
				epochObjects set[count epochObjects,[_idKey,_type,_ownerID,_worldspace,_damage]];
				localIds set[count localIds,parseNumber(_idKey)];
				_skip = true;
			};

			if(count _worldspace >= 2) then
			{
				if((typeName (_worldspace select 0)) == "STRING") then {
					_worldspace set[0,call compile (_worldspace select 0)];
					_worldspace set[1,call compile (_worldspace select 1)];
				};

				_dir = _worldspace select 0;

				if(count (_worldspace select 1) == 3) then {
					_pos = _worldspace select 1;
					_wsDone = true;
				};
			};

			if(_skip) then {

				if(count _worldspace < 3) then {
					_worldspace set[count _worldspace,"0"];
				};

				_ownerPUID = _worldspace select 2;

				if(_damage < 1) then {
					_object = _type createVehicleLocal[0,0,0];
					_object setVariable["lastUpdate",time];
					_object setVariable["ObjectID",_idKey];
					_object setVariable["OwnerPUID",_ownerPUID];
					_object setVariable["CharacterID",_ownerID];
					_object setdir _dir;
					_object setPosATL _pos;
					_object setDamage _damage;
					_object addEventhandler["HandleDamage",{false}];
					_object enableSimulation false;

					if((typeOf _object) in dayz_allowedObjects) then {
						_object setVariable["OEMPos",_pos];
					};

					serverObjects set[parseNumber(_idKey),_object];
					_object = nil;

				};

			} else {

				if(!_wsDone) then {
					if(count _worldspace >= 1) then { _dir = _worldspace select 0; };
					_pos = [getMarkerPos "center",0,4000,10,0,2000,0] call BIS_fnc_findSafePos;

					if(count _pos < 3) then { _pos = [_pos select 0,_pos select 1,0]; };
					diag_log ("MOVED OBJ: " + str(_idKey) + " of class " + _type + " to pos: " + str(_pos));
				};

				if(count _worldspace < 3) then {
					_worldspace set[count _worldspace,"0"];
				};

				_ownerPUID = _worldspace select 2;

				if(_damage < 1) then {
					_object = createVehicle[_type,_pos,[],0,"CAN_COLLIDE"];
					_object setVariable["lastUpdate",time];
					_object setVariable["ObjectID",_idKey,true];
					_object setVariable["OwnerPUID",_ownerPUID,true];
					_lockable = 0;

					if(isNumber (configFile >> "CfgVehicles" >> _type >> "lockable")) then {
						_lockable = getNumber(configFile >> "CfgVehicles" >> _type >> "lockable");
					};

					if(_lockable == 4) then {
						_codeCount = (count (toArray _ownerID));
						if(_codeCount == 3) then { _ownerID = format["0%1",_ownerID]; };
						if(_codeCount == 2) then { _ownerID = format["00%1",_ownerID]; };
						if(_codeCount == 1) then { _ownerID = format["000%1",_ownerID]; };
					};

					if(_lockable == 3) then {
						_codeCount = (count (toArray _ownerID));
						if(_codeCount == 2) then { _ownerID = format["0%1",_ownerID]; };
						if(_codeCount == 1) then { _ownerID = format["00%1",_ownerID]; };
					};
					_object setVariable["CharacterID",_ownerID,true];
					clearWeaponCargoGlobal _object;
					clearMagazineCargoGlobal _object;
					_object setdir _dir;
					_object setPosATL _pos;
					_object setDamage _damage;

					if((typeOf _object) in dayz_allowedObjects) then {
						if(DZE_GodModeBase) then {
							_object addEventhandler["HandleDamage",{false}];
						} else {
							_object addMPEventhandler["MPKilled",{_this call object_handleServerKilled;}];
						};
						_object enableSimulation false;
						_object setVariable["OEMPos",_pos,true];
					};

					if(count _inventory > 0) then {
						if(_type in DZE_LockedStorage) then {
							_object setVariable["WeaponCargo",(_inventory select 0),true];
							_object setVariable["MagazineCargo",(_inventory select 1),true];
							_object setVariable["BackpackCargo",(_inventory select 2),true];
						} else {
							_objWpnTypes = (_inventory select 0) select 0;
							_objWpnQty = (_inventory select 0) select 1;
							_countr = 0;					
							{
								if(_x in (DZE_REPLACE_WEAPONS select 0)) then {
									_x = (DZE_REPLACE_WEAPONS select 1) select ((DZE_REPLACE_WEAPONS select 0) find _x);
								};
								_isOK = isClass(configFile >> "CfgWeapons" >> _x);

								if(_isOK) then {
									_object addWeaponCargoGlobal [_x,(_objWpnQty select _countr)];
								};
								_countr = _countr + 1;
							} count _objWpnTypes;

							_objWpnTypes	= (_inventory select 1) select 0;
							_objWpnQty		= (_inventory select 1) select 1;
							_countr			= 0;

							{
								if(_x == "BoltSteel") then { _x = "WoodenArrow" };
								if(_x == "ItemTent") then { _x = "ItemTentOld" };

								_isOK = isClass(configFile >> "CfgMagazines" >> _x);
								if(_isOK) then {
									_object addMagazineCargoGlobal [_x,(_objWpnQty select _countr)];
								};
								_countr = _countr + 1;
							} count _objWpnTypes;

							_objWpnTypes	= (_inventory select 2) select 0;
							_objWpnQty		= (_inventory select 2) select 1;
							_countr			= 0;

							{
								_isOK = isClass(configFile >> "CfgVehicles" >> _x);

								if(_isOK) then {
									_object addBackpackCargoGlobal [_x,(_objWpnQty select _countr)];
								};
								_countr = _countr + 1;
							} count _objWpnTypes;
						};
					};

					if(_object isKindOf "AllVehicles") then {
						{
							_selection = _x select 0;
							_dam = _x select 1;

							if(_selection in dayZ_explosiveParts && _dam > 0.8) then {_dam = 0.8};
							[_object,_selection,_dam] call object_setFixServer;
						} count _hitpoints;
						_object setFuel _fuel;

						if(!((typeOf _object) in dayz_allowedObjects)) then {
							_object call fnc_veh_ResetEH;		
							if(_ownerID != "0" && !(_object isKindOf "Bicycle")) then {
								_object setvehiclelock "locked";
							} else {
								_totalvehicles = _totalvehicles + 1;
								serverVehicleCounter set[count serverVehicleCounter,_type];
							};
						};
					};
					PVDZE_serverObjectMonitor set[count PVDZE_serverObjectMonitor,_object];
				};
			};
		};

		_hiveResponse = nil;
	};

	diag_log format["HIVE: Objects spawned on the server, sending %1 objects to clients",(count epochObjects)];

	totalepochObjects = count epochObjects;

	publicVariable "totalepochObjects";
	publicVariable "epochObjects";

	epochObjects = nil;

	processInitCommands;

	if!(DZE_ConfigTrader) then {

		trader_data = [];

		{
			_traderid	= _x;
			_key		= format["CHILD:399:%1:",_traderid];
			_data		= "HiveEXT" callExtension _key;
			_result		= call compile format["%1",_data];
			_status		= _result select 0;

			if(_status == "ObjectStreamStart") then {
				private["_items","_val"];
				_val = _result select 1;
				trade_items = [];
				for "_i" from 1 to _val do {
					private["_data","_result"];
					_data = "HiveEXT" callExtension _key;
					_result = call compile format["%1",_data];
					trade_items set[count trade_items,
						[
							((_result select 1) select 0),
							((_result select 1) select 1),
							((_result select 3) select 0),
							((_result select 4) select 0),
							(_result select 7)
						]
					];
				};
				trader_data set[_x,trade_items];
			};
		} forEach trader_ids;

		publicVariable "trader_data";

		trade_items = nil;
		trader_data = nil;
	};

	_vehLimit = MaxVehicleLimit - _totalvehicles;

	if(_vehLimit > 0) then {
		diag_log ("HIVE: Spawning # of Vehicles: " + str(_vehLimit));
		for "_x" from 1 to _vehLimit do {
			[] spawn spawn_vehicles;
		};
	} else {
		diag_log "HIVE: Vehicle Spawn limit reached!";
	};

	diag_log ("HIVE: Spawning # of Ammo Boxes: " + str(MaxAmmoBoxes));
	for "_x" from 1 to MaxAmmoBoxes do {
		[] spawn spawn_ammosupply;
	};

	if(isnil "dayz_MapArea") 	then { dayz_MapArea = 10000; };
	if(isnil "HeliCrashArea")	then { HeliCrashArea = dayz_MapArea / 2; };

	if(isDedicated) then {
		_id = [] spawn server_spawnEvents;
		[] spawn {
			private["_id"];
			sleep 200; 
			waitUntil {!isNil "server_spawnCleanAnimals"};
			_id = [] execFSM "\z\addons\dayz_server\system\server_cleanup.fsm";
		};
		_debugMarkerPosition = getMarkerPos "respawn_west";
		_debugMarkerPosition = [(_debugMarkerPosition select 0),(_debugMarkerPosition select 1),1];
		_vehicle_0 = createVehicle["DebugBox_DZ",_debugMarkerPosition,[],0,"CAN_COLLIDE"];
		_vehicle_0 setPos _debugMarkerPosition;
		_vehicle_0 setVariable["ObjectID","1",true];

		if(isnil "spawnMarkerCount") then {
			spawnMarkerCount = 10;
		};
		actualSpawnMarkerCount = 0;
		for "_i" from 0 to spawnMarkerCount do {
			if(!([(getMarkerPos format["spawn%1",_i]),[0,0,0]] call BIS_fnc_areEqual)) then {
				actualSpawnMarkerCount = actualSpawnMarkerCount + 1;
			} else {
				_i = spawnMarkerCount + 99;
			};
		};
		diag_log format["Total Number of spawn locations %1",actualSpawnMarkerCount];
		endLoadingScreen;
	};

	ExecVM "\z\addons\dayz_server\WAI\init.sqf";
	allowConnection = true;	
	sm_done = true;
	publicVariable "sm_done";

	'AD_AntiDupePlayer' addPublicVariableEventHandler {
		[] spawn {
			private["_plyr","_amnt"];
			waitUntil {!isNull AD_AntiDupePlayer};
			_plyr = AD_AntiDupePlayer;
			_amnt = _plyr getVariable['ClearToLeave',0];
			_plyr setVariable['ClearToLeave',_amnt+1,true];
		};
	};
};