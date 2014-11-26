_nil = [] execVM "custom\remote\remote.sqf";

[] spawn {

	private["_isNew"];

	_isNew = player getVariable["isNew",false];

	execVM "custom\service_point\service_point.sqf";
	execVM "custom\no_voice\no_voice.sqf";
	execVM "custom\gold_coins\init.sqf";

	if (_isNew) then {
		execVM "custom\welcome_screen\welcome_screen.sqf";
	};
};

[] spawn {

	private["_markers"];

	waitUntil{sleep .5; !isNil "allMarkers"};

	_markers = allMarkers;

	{

		private["_name","_pos","_type"];

		_name 	= _x select 0;
		_pos 	= _x select 1;
		_type 	= _x select 2;

		call {
			if(_type == "ellipse") exitWith {

				private["_radius","_marker","_dot"];

				_radius = _x select 3;
				_color	= _x select 4;

				_marker = createMarkerLocal [(_type + _name), _pos];
				_marker setMarkerColorLocal _color;
				_marker setMarkerShapeLocal "ELLIPSE";
				_marker setMarkerBrushLocal "SolidBorder";
				_marker setMarkerSizeLocal [_radius,_radius];
				_marker setMarkerTextLocal _name;

				_dot = createMarkerLocal [("mil_dot" + _name),_pos];
				_dot setMarkerColorLocal _color;
				_dot setMarkerTypeLocal "mil_dot";
				_dot setMarkerTextLocal _name;

			};

			if(_type == "icon") exitWith {
				
				private["_marker","_icon"];

				_icon = _x select 3;

				_marker = createMarkerLocal [(_type + _name + _icon),_pos];
				_marker setMarkerColorLocal "ColorBlack";
				_marker setMarkerTypeLocal _icon;
				_marker setMarkerTextLocal _name;
			};

		};

	} count _markers;

};

[] spawn {
	
	private ["_idKey","_type","_ownerID","_worldspace","_damage","_dir","_pos","_ownerPUID"];

	waitUntil {sleep .5; !isNil "localObjects"};

	spawnedObjects 	= [];

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

		if (count _worldspace >= 2) then
		{
			if ((typeName (_worldspace select 0)) == "STRING") then {
				_worldspace set [0, call compile (_worldspace select 0)];
				_worldspace set [1, call compile (_worldspace select 1)];
			};

			_dir = _worldspace select 0;
			
			if (count (_worldspace select 1) == 3) then {
				_pos = _worldspace select 1;
			};
		};

		if (count _worldspace < 3) then {
			_worldspace set [count _worldspace, "0"];
		};

		_ownerPUID = _worldspace select 2;

		if (_damage < 1) then {
			_object = _type createVehicleLocal [0,0,0];
			_object setVariable ["lastUpdate",time];
			_object setVariable ["ObjectID",_idKey];
			_object setVariable ["OwnerPUID",_ownerPUID];
			_object setVariable ["CharacterID",_ownerID];
			_object setdir _dir;
			_object setposATL _pos;
			_object setDamage _damage;
			_object addEventHandler ["HandleDamage", {false}];
			_object enableSimulation false;

			if ((typeOf _object) in dayz_allowedObjects) then {
				_object setVariable ["OEMPos",_pos];
			};

			spawnedObjects set[count spawnedObjects, _object];
		};
	} count localObjects;

	spawnedLoaded = true;

};

[] spawn {

	private ["_objects","_total","_spawned","_upd_range","_pos_player","_object","_t","_moved","_a","_r","_i"];

	waitUntil {sleep .5; !isNil "allObjects"};

	_objects 	= allObjects;
	allObjects	= nil;
	_total		= count _objects;
	_spawned 	= [];
	_upd_range 	= 300;
	_pos_player = [player] call FNC_GetPos;

	_t = diag_tickTime;
	{
		_object = (_x select 0) createVehicleLocal [0,0,0];
		_object setDir (_x select 2);
		_object setPos (_x select 1);

		if(count _x > 3 && (_x select 3)) then {
			_object setVehicleLock "LOCKED";
		};
		_spawned set[count _spawned,[_object,_x]];
	} count _objects;

	_objects = [];

	diag_log format["[DynObj] Initializing %2 objects in %1s ",str(diag_tickTime - _t),_total];

	objectsLoaded = true;

	waitUntil {!isNil "dayz_animalCheck"};

	while{alive player} do {

		_moved = _pos_player distance player;

		if(_moved > _upd_range) then { // Only update when player has moved at least _upd_range meters from his last saved position

			if(DZEdebug) then {
				diag_log format["[DynObj] Player moved %1m since last cycle, checking for new/removable objects",_moved];

				_t = diag_tickTime; // start timer for debug purposes
				_a = 0; // keep track of how many objects added this cycle
				_r = 0; // keep track of how many objects removed this cycle
			};

			_pos_player = [player] call FNC_GetPos;
			_i 			= 0; // keep track of object index (outperforms forEach / _foreachIndex)

			{

				if(player distance (_x select 1) < 1500) then {
					_object = (_x select 0) createVehicleLocal [0,0,0];
					_object setDir (_x select 2);
					_object setPos (_x select 1);

					if(count _x > 3 && (_x select 3)) then {
						_object setVehicleLock "LOCKED";
					};

					if(DZEdebug) then { _a = _a + 1; };

					_spawned set[count _spawned,[_object,_x]];
					_objects set[_i,-1];
				};
				_i = _i + 1;
			} count _objects;

			_objects = _objects - [-1]; // remove added objects from objects array
			_i = 0;	// reset counter for use in spawned array

			{
				if(player distance (_x select 0) > 1750) then {
					_spawned set[_i,-1];
					_objects set[count _objects, (_x select 1)];
					deleteVehicle (_x select 0);
					if(DZEdebug) then { _r = _r + 1; };
				};
				_i = _i + 1;
			} count _spawned;

			_spawned = _spawned - [-1];

			if(DZEdebug) then { diag_log format["[DynObj] Added % objects - removed %2 objects - total active %3 - cycle took %4s",_a,_r,count _spawned,str (diag_tickTime - _t)]; };

		} else {
			if(DZEdebug) then { diag_log format["[DynObj] Player moved %1m, not updating until %2m",_moved,_upd_range]; };
		};

		if(_moved > _upd_range-(_upd_range/4)) then {
			sleep 3; // almost at the edge, updating faster
		} else {
			sleep 6;
		};

	};
	
};

[] spawn {
	
	client_remove_object = {

		private ["_removed","_total","_t"];

		waitUntil {sleep .5; (spawnedLoaded)};

		_removed	= _this select 1;
		_total		= 0;

		diag_log format["[EpochBuild Remover] Removing %1 objects",count(_removed)];

		_t = diag_tickTime;
		
		{
			if(_x getVariable["ObjectID",false] in _removed) then {
				deleteVehicle _x;
				_total = _total + 1;
			};
		} count spawnedObjects;

		diag_log format["[EpochBuild Remover] Removed %2 objects in %1s ",str(diag_tickTime - _t),_total];
	};

	"deleteObjects" addPublicVariableEventHandler { (_this) spawn client_remove_object; };

};