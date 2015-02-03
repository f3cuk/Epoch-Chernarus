client_remove_object = {

	private["_removed","_t","_i"];

	waitUntil {(epochObjectsLoaded && missionObjectsLoaded)};

	_removed = _this select 1;

	if(!isNil "already_removed") then {_removed = _removed - already_removed;};

	diag_log format["[EpochBuild Remover] Removing %1 objects",(count _removed)];

	_t = diag_tickTime;
	_i = 0;

	{
		if((_x select 0) in _removed) then {
			deletevehicle (_x select 1);
			already_removed set[count already_removed,(_x select 0)];
			spawned set[_i,-1];
		};
		_i = _i + 1;
	} count spawned;

	spawned = spawned - [-1];
	_i = 0;

	{
		if((_x select 0) in _removed) then {
			already_removed set[count already_removed,(_x select 0)];
			hidden set[_i,-1];
		};
		_i = _i + 1;
	} count hidden;

	hidden = hidden - [-1];

	diag_log format["[EpochBuild Remover] Removed %1 objects in %2s",(count _removed),str(diag_tickTime - _t)];
};

"deleteObjects" addPublicVariableEventHandler { (_this) spawn client_remove_object; };

spawn_mission_object = {

	private["_object","_object_array"];

	_object_array = _this select 0;

	_object = (_object_array select 0) createVehicleLocal[0,0,0];
	_object setDir (_object_array select 2);
	_object setPos (_object_array select 1);
	_object allowDammage false;
	
	if((_object_array select 0) in localLights) then { 
		_object enableSimulation true;
	} else {
		_object enableSimulation false;
	};

	if(count _object_array > 3 && (_object_array select 3)) then {
		_object setVehicleLock "LOCKED";
	};

	_object

};

spawn_epoch_object = {

	private["_idKey","_type","_ownerID","_worldspace","_damage","_dir","_pos","_ownerPUID","_object","_object_array"];

	_object_array = _this select 0;

	_idKey		= _object_array select 0;
	_type		= _object_array select 1;
	_ownerID	= _object_array select 2;
	_worldspace	= _object_array select 3;
	_damage		= _object_array select 4;
	_dir		= 0;
	_pos		= [0,0,0];

	if(count _worldspace >= 2) then {
		if((typeName (_worldspace select 0)) == "STRING") then {
			_worldspace set[0,call compile (_worldspace select 0)];
			_worldspace set[1,call compile (_worldspace select 1)];
		};

		_dir = _worldspace select 0;

		if(count (_worldspace select 1) == 3) then {
			_pos = _worldspace select 1;
		};
	};

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
	
		if(_type in localLights) then { 
			_object enableSimulation true;
		} else {
			_object enableSimulation false;
		};
		
		if((typeOf _object) in dayz_allowedObjects) then {
			_object setVariable["OEMPos",_pos];
		};
	};

	[_object,_idKey]
};

[] spawn {

	dayz_loadScreenMsg = "Initializing object spawn..";

	waitUntil {sleep .2; (count epochObjects == totalEpochObjects) && (count missionObjects == totalmissionObjects)};

	sleep 0.1;

	dayz_loadScreenMsg = "Starting object spawn..";

	spawnedIds		= [];
	totalobjects	= count (epochObjects + missionObjects);
	loadedobjects	= 0;

	dayz_loadScreenMsg = format["Loading objects (0/%1)",totalobjects];

	[] spawn {

		private["_t","_object","_total"];

		_total	= 0;
		_t		= diag_tickTime;

		diag_log format["[Epoch Objects] Spawning %1 industructable Epoch buildables",totalEpochObjects];

		{

			loadedobjects = loadedobjects + 1;

			private["_object","_id"];

			if(!((_x select 0) in deleteObjects)) then {

				_object = [_x] call spawn_epoch_object;
				_id 	= parseNumber(_object select 1);

				spawned set[count spawned,[_id,(_object select 0),_X]];
				spawnedIds set[count spawnedIds,_id];

				_total = _total + 1;
				
			};

			dayz_loadScreenMsg = format["Loading objects (%1/%2)",loadedobjects,_total];

		} count epochObjects;

		epochObjects = nil;

		diag_log format["[Epoch Objects] Initialized %2 Epoch buildables in %1s ",str(diag_tickTime - _t),_total];

		epochObjectsLoaded = true;

	};

	[] spawn {

		private["_object","_t"];

		_t = diag_tickTime;

		diag_log format["[Mission Objects] Spawning %1 mission objects",totalmissionObjects];

		{
			loadedobjects = loadedobjects + 1;
			_object = [_x] call spawn_mission_object;
			spawned set[count spawned,[-1,_object,_x]];
			dayz_loadScreenMsg = format["Loading objects (%1/%2)",loadedobjects,totalobjects];
		} count missionObjects;

		_object			= nil;
		missionObjects	= nil;

		diag_log format["[Mission Objects] Initialized %2 mission objects in %1s ",str(diag_tickTime - _t),totalmissionObjects];

		missionObjectsLoaded = true;

	};

};

[] spawn {

	private["_upd_range","_diameter","_pos_player","_moved","_i"];
	if(DZEdebug) then { private["_t","_a","_r"]; };

	waitUntil {!isNil "dayz_animalCheck"};
	
	hidden		= [];
	_upd_range 	= 300;
	_diameter	= 1500;
	_pos_player = [0,0,0];

	while{true} do {

		_moved = _pos_player distance player;

		if(_moved > _upd_range) then { // Only update when player has moved at least _upd_range meters from his last saved position

			if(DZEdebug) then {
				diag_log format["[DynObj] Player moved %1m since last cycle, checking for new/removable objects",_moved];

				_t = diag_tickTime; // start timer for debug purposes
				_a = 0; // keep track of how many objects added this cycle
				_r = 0; // keep track of how many objects removed this cycle
			};

			_pos_player = [player] call FNC_GetPos;
			_i			= 0; // keep track of object index (outperforms forEach / _foreachIndex)

			{

				private["_object","_id","_removed"];

				if(player distance (_x select 2) < _diameter) then {
					
					if((_x select 0) == -1) then {
						_object = [_x select 1] call spawn_mission_object;
						_id		= -1;
					} else {
						_object = [_x select 1] call spawn_epoch_object;
						_id 	= parseNumber(_object select 1);
						_object = (_object select 0);
					};

					spawned set[count spawned,[_id,_object,(_x select 1)]];
					hidden set[_i,-1];

					if(DZEdebug) then { _a = _a + 1; };
				};
				_i = _i + 1;
			} count hidden;

			hidden = hidden - [-1];
			_i = 0;

			{

				if(player distance (_x select 1) > (_diameter - 250)) then {
					spawned set[_i,-1];
					hidden set[count hidden,[(_x select 0),(_x select 2),[(_x select 1)] call FNC_GetPos]];
					deleteVehicle (_x select 1);
					if(DZEdebug) then { _r = _r + 1; };
				};
				_i = _i + 1;
			} count spawned;

			spawned = spawned - [-1];

			if(DZEdebug) then { diag_log format["[DynObj] Added %1 objects - removed %2 objects - total active %3 - cycle took %4s",_a,_r,count _spawned,str (diag_tickTime - _t)]; };

		} else {
			if(DZEdebug) then { diag_log format["[DynObj] Player moved %1m, not updating until %2m",_moved,_upd_range]; };
		};

		if(_moved > _upd_range-(_upd_range/4)) then {
			sleep 3;
		} else {
			sleep 6;
		};

	};

};

[] spawn {
	uiSleep 180;
	if(!preload_done) then {
		player enableSimulation false;
		cutText["Something went wrong with loading the objects, auto moving you to the lobby in 5 seconds. Please relog.","BLACK"];
		PVDZE_log = [format["[NO_OBJECTS] Player %1 (%2) was kicked to the lobby because of no objects.",(name player),(getPlayerUID player)]];
		publicVariableServer "PVDZE_log";
		uiSleep 5;
		endMission "END1";
	};
};