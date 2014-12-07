
[] spawn {

	private["_idKey","_type","_ownerID","_worldspace","_damage","_dir","_pos","_ownerPUID","_object"];

	waitUntil {!isNil "localObjects"};

	spawnedObjects 	= [];
	removed_objects = [];
	spawnedIds		= [];

	dayz_loadScreenMsg = "Loading Player Bases..";

	diag_log format["[EpochBuild] Spawning in %1 industructable Epoch buildables",(count localObjects)];

	{
		_idKey		= _X select 0;
		_type		= _x select 1;
		_ownerID	= _x select 2;
		_worldspace	= _x select 3;
		_damage		= _x select 4;
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

			spawnedObjects set[count spawnedObjects,[parseNumber(_idKey),_object]];
			spawnedIds set[count spawnedIds,parseNumber(_idKey)];
		};
	} count localObjects;

	spawnedLoaded = true;

};

[] spawn {

	private["_total","_object","_t"];

	waitUntil {!isNil "allObjects"};

	_total	= count allObjects;
	_t		= diag_tickTime;

	{
		_object = (_x select 0) createVehicleLocal[0,0,0];
		_object setDir (_x select 2);
		_object setPos (_x select 1);
		_object allowDammage false;
		
		if((_x select 0) in localLights) then { 
			_object enableSimulation true;
		} else {
			_object enableSimulation false;
		};

		if(count _x > 3 && (_x select 3)) then {
			_object setVehicleLock "LOCKED";
		};
	} count allObjects;

	_object		= nil;
	allObjects	= nil;

	diag_log format["[DynObj] Initializing %2 objects in %1s ",str(diag_tickTime - _t),_total];

	objectsLoaded = true;

	waitUntil {!isNil "dayz_animalCheck"};

};

[] spawn {

	client_remove_object = {

		private["_removed"];

		waitUntil {(spawnedLoaded)};

		_removed = _this select 1;

		if(!isNil "removed_objects") then {_removed = _removed - removed_objects;};

		diag_log format["[EpochBuild Remover] Removing %1 objects",(count _removed)];

		_t = diag_tickTime;

		{
			if((_x select 0) in _removed) then {
				deletevehicle (_x select 1);
				removed_objects set[count removed_objects,(_x select 0)];
			};
		} count spawnedObjects;

		diag_log format["[EpochBuild Remover] Removed %1 objects in %1s",(count _removed),str(diag_tickTime - _t)];
	};

	"deleteObjects" addPublicVariableEventHandler { (_this) spawn client_remove_object; };

};

[] spawn {
	uiSleep 120;
	if(!preload_done) then {
		player enableSimulation false;
		cutText["Something went wrong with loading the objects,auto moving you to the lobby in 5 seconds. Please relog.","BLACK"];
		PVDZE_log = [format["[NO_OBJECTS] Player %1 (%2) was kicked to the lobby because of no objects.",(name player),(getPlayerUID player)]];
		publicVariableServer "PVDZE_log";
		uiSleep 5;
		endMission "END1";
	};
};
