private ["_find_pos","_spawn_crate"];

STOP_ROYALE = false;

royale_find_pos = {
	_pos = [(_this select 0),0,(_this select 1),0,0,1,0] call BIS_fnc_findSafePos;

	while{surfaceIsWater _pos} do {
		_pos = [(_this select 0),0,(_this select 1),0,0,1,0] call BIS_fnc_findSafePos;
	};

	_pos
};

royale_spawn_crate = {
		
	private["_ammo","_crate","_weapon","_item","_num_items","_num_weapons","_weapons_array","_item_array"];

	_crate = _this select 0;
	_crate setVariable["ObjectID","1",true];
	_crate setVariable["permaLoot",true];

	_num_weapons = _this select 1;
	_weapons_array = ai_wep_random call BIS_fnc_selectRandom;;

	_num_items = _this select 2;
	_item_array = crate_items_medical;

	clearWeaponCargoGlobal _crate;
	clearMagazineCargoGlobal _crate;

	if(_num_weapons > 0) then {

		_num_weapons = (ceil((_num_weapons) / 2) + floor(random (_num_weapons / 2)));

		for "_i" from 1 to _num_weapons do {
			_weapon = _weapons_array call BIS_fnc_selectRandom;
			_ammo = _weapon call find_suitable_ammunition;
			_crate addWeaponCargoGlobal[_weapon,1];
			_crate addMagazineCargoGlobal[_ammo,(1 + floor(random 3))];
		};

	};

	if(_num_items > 0) then {

		_num_items = (ceil((_num_items) / 2) + floor(random (_num_items / 2)));

		for "_i" from 1 to _num_items do {
			_item = _item_array call BIS_fnc_selectRandom;

			if(typeName (_item) == "ARRAY") then {
				_crate addMagazineCargoGlobal[_item select 0,_item select 1];
			} else {
				_crate addMagazineCargoGlobal[_item,1];
			};
		};

	};

	if(random 100 < 20) then {
		_backpack = crate_backpacks_all call BIS_fnc_selectRandom;
		_crate addBackpackCargoGlobal[_backpack,1];
	};

	if(random 100 < 2) then {
		_item = crate_items_high_value call BIS_fnc_selectRandom;
		_crate addMagazineCargoGlobal[_item,1];
	};

	_crate
};

[] spawn {
	_center = [13620.6,3061.17,0];
	_dis = 650;
	_crates = [];
	for "_i" from 1 to 26 do {
		private["_crate_type","_pos","_crate"];
		_crate_type = crates_small call BIS_fnc_selectRandom;
		_pos = [_center,_dis] call royale_find_pos;
		_crate = createVehicle[_crate_type,[(_pos select 0),(_pos select 1),0],[],0,"CAN_COLLIDE"];
		_crates set[count _crates,[_crate,(floor(round 2) + 1),0] call royale_spawn_crate];
		diag_log format["[Royale] Spawned a weapon crate at %1",_pos];
	};
	for "_i" from 1 to 26 do {
		private["_crate_type","_pos","_crate"];
		_crate_type = crates_small call BIS_fnc_selectRandom;
		_pos = [_center,_dis] call royale_find_pos;
		_crate = createVehicle[_crate_type,[(_pos select 0),(_pos select 1),0],[],0,"CAN_COLLIDE"];
		_crates set[count _crates,[_crate,0,(floor(round 6) + 2)] call royale_spawn_crate];
		diag_log format["[Royale] Spawned a supply crate at %1",_pos];
	};

	RemoteMessage = ["dynamic_text",["Skalisty Royal","Let the games begin!"]];
	publicVariable "RemoteMessage";

	waitUntil{STOP_ROYALE};

	{
		deleteVehicle _x;
	} foreach _crates;
};