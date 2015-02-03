private ["_player"];

_player = _this select 0;
royale_vehicle = vehicle _player;

if(royale_vehicle == _player) then {
	RemoteMessage = ["private",[getPlayerUID _player,"[Error] You need to be in a vehicle (with all the participants) to start Royale"]];
	publicVariable "RemoteMessage";
} else {

	if(!isNil "ROYALE_RUNNING") then {
		if(ROYALE_RUNNING) then {
			call royale_end;
		};
	};

	if(count (crew (royale_vehicle)) < 2) exitWith {
		RemoteMessage = ["private",[getPlayerUID _player,"[Error] At the very least you need 2 players to start Royale"]];
		publicVariable "RemoteMessage";	
	};

	STOP_ROYALE			= false;
	ROYALE_RUNNING		= true;
	royale_contenders	= [];
	crates				= [];

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

	royale_player_init = {
		private["_tmpu","_do"];

		_do = format["if(getPlayerUID player == '%1') then {
			{player removeMagazine _x;} forEach (magazines player);
			{player removeWeapon _x;} forEach (weapons player);
			removeBackpack player;
			player setVariable['CashMoney',0,true];
			player addWeapon 'itemMap'; 
		};",(getPlayerUID _this)];
		_tmpu = createAgent['Rabbit',[2500,2500,0],[],0,'FORM'];
		_tmpu setVehicleInit _do;
		processInitCommands;
		clearVehicleInit _tmpu;
		deleteVehicle _tmpu;

		_this setVariable["Royale",true];
		_this call royale_heal;
	};

	royale_heal = {
		private["_player"];

		_player = _this;

		_do = format["if(getPlayerUID player == '%1') then {
			dayz_sourceBleeding = objNull;
			r_player_blood = r_player_bloodTotal;
			r_player_inpain = false;
			r_player_infected = false;
			r_player_injured = false;
			dayz_hunger = 0;
			dayz_thirst = 0;
			dayz_temperatur = 37;
			r_fracture_legs = false;
			r_fracture_arms = false;
			r_player_dead = false;
			r_player_unconscious = false;
			r_player_loaded = false;
			r_player_cardiac = false;
			r_player_lowblood = false;
			r_player_timeout = 0;
			r_handlercount = 0;
			r_interrupt = false;
			r_doLoop = false;
			r_drag_sqf = false;
			r_self = false;
			r_action = false;
			r_action_unload = false;
			r_player_handler = false;
			r_player_handler1 = false;
			disableUserInput false;
			'dynamicBlur' ppEffectAdjust [0];
			'dynamicBlur' ppEffectCommit 5;
			player setHit['legs',0];
			player setVariable['messing',[dayz_hunger,dayz_thirst],true];
			player setVariable['NORRN_unconscious',false,true];
			player setVariable['USEC_infected',false,true];
			player setVariable['USEC_injured',false,true];
			player setVariable['USEC_inPain',false,true];
			player setVariable['USEC_isCardiac',false,true];
			player setVariable['USEC_lowBlood',false,true];
			player setVariable['USEC_BloodQty',12000,true];
			player setVariable['unconsciousTime',0,true];
			player setVariable['hit_legs',0,true];
			player setVariable['hit_hands',0,true];
			player setVariable['medForceUpdate',true,true];
			player setdamage 0;
			0 fadeSound 1;
			resetCamShake;
		};",(getPlayerUID _player)];
		_tmpu = createAgent['Rabbit',[2500,2500,0],[],0,'FORM'];
		_tmpu setVehicleInit _do;
		processInitCommands;
		clearVehicleInit _tmpu;
		deleteVehicle _tmpu;
	};

	royale_alive_check = {
		private["_alive"];

		_alive = royale_total_contenders;

		while{ROYALE_RUNNING} do {
			private["_new_alive"];

			{
				if(!(alive _x)) then { 
					royale_death set[count royale_death,[name (royale_contenders select _forEachIndex),serverTime]];
					royale_contenders set[_forEachIndex,-1];
				};
			} forEach royale_contenders;

			royale_contenders	= royale_contenders - [-1];
			_new_alive			= count royale_contenders;

			if(_new_alive != _alive || _new_alive < 2) then {
				_diff = _alive - _new_alive;
				_alive = _new_alive;
				if(_alive > 1) then {
					RemoteMessage = ["dynamic_text",[royale_name,format["%1 players left alive",_alive]]];
					publicVariable "RemoteMessage";
					if(_alive < 4) then {
						private["_names"];
						_names = [];

						{
							_names set[count _names,name _x];
						} count royale_contenders;

						diag_log format["[%1] Entering final stage with %2",royale_name,_names];
					};

					/*

						[_diff] spawn {
							for "_i" from 1 to (_this select 0) do {
								[objNull,royale_marker,rSAY,"Royale_One_Down",25] call RE;
								sleep 3;
							};
						};

					*/
				} else {

					ROYALE_FINISHED = true;

					if(_alive == 1) exitWith {
						_winner = (royale_contenders select 0);

						diag_log format["[%1] Has ended, winner %2 (%3)",royale_name,name _winner,getPlayerUID _winner];

						deleteMarker royale_marker;
						deleteMarker royale_dot;

						royale_marker = createMarker["royale_marker",royale_pos];
						royale_marker setMarkerColor "ColorBlue";
						royale_marker setMarkerShape "ELLIPSE";
						royale_marker setMarkerBrush "Border";
						royale_marker setMarkerSize [royale_radius,royale_radius];
						royale_marker setMarkerText royale_name;

						royale_dot = createMarker["royale_dot",royale_pos];
						royale_dot setMarkerColor "ColorBlue";
						royale_dot setMarkerType "o_inf";
						royale_dot setMarkerText royale_name;

						current_radius = royale_radius;
						current_pos	= royale_pos;

						RemoteMessage = ["dynamic_text",[royale_name,format["We got a winner! Congratulations to %1 for being a beast!",(name _winner)]]];
						publicVariable "RemoteMessage";

						sleep 5;

						RemoteMessage = ["private",[getPlayerUID _winner,format["You have 10 minutes to loot, after that the area becomes public again and you will get teleported to %3, move to the center if you want a early teleport",(name _winner),royale_name,(winner_location select 0)]]];
						publicVariable "RemoteMessage";

						sleep 600;

						if(ROYALE_RUNNING) then {

							if(alive _winner) then {
								_winner setPos (winner_location select 1);
							};

							[] spawn royale_end;

						};
					};		

					diag_log format["[%1]: Has ended undecided"];

					RemoteMessage = ["dynamic_text",[royale_name,format["%1 has ended undecided, better luck next time..",royale_name]]];
					publicVariable "RemoteMessage";

					[] spawn royale_end;

				};
			};
			sleep 2;
		};

	};

	royale_remove_unwanted = {

		while{ROYALE_RUNNING} do {
			{
				if(!(_x in royale_contenders)) then {
					_x setPos royale_safezone;
				};
			} count (royale_pos nearEntities["CAManBase",royale_radius]);

			if(count royale_contenders > 1) then {
				{
					private["_pos","_do","_tmpu","_playerUID"];
					_pos = getPos _x;
					_pos set[2,0];
					if((_pos distance current_pos > (current_radius + 5)) && (vehicle _x == _x)) then {
						_playerUID = getPlayerUID _x;
						_do = "if(getPlayerUID player == "+str _playerUID+") then {
								r_player_blood = r_player_blood - 800;
								player setVariable['USEC_BloodQty',r_player_blood,true];
								playSound 'heartbeat_1';
							};";
						_tmpu=createAgent['Rabbit',[2500,2500,0],[],0,'FORM'];
						_tmpu setVehicleInit _do;
						processInitCommands;
						clearVehicleInit _tmpu;
						deleteVehicle _tmpu;
					};
				} count royale_contenders;
			} else {
				if(count royale_contenders == 1) then {
					private["_pos","_winner"];

					_winner = royale_contenders select 0;
					_pos = getPos _winner;

					if(_pos distance royale_pos < 5) then {
						_winner setPos (winner_location select 1);
						[] spawn royale_end;
					};
				};
			};

			sleep 5;
		};
	};

	royale_end = {
		ROYALE_RUNNING = false;

		deleteMarker royale_marker;
		deleteMarker royale_dot;

		{
			deleteVehicle _x;
		} foreach crates;

		royale_marker = nil;
		royale_dot = nil;
		crates = nil;

		{
			if(_x isKindOf "CAManBase") then {
				if(_x distance royale_pos < (royale_radius + 10)) then {
					deleteVehicle _x;
				}
			};
		} count allDead;

		diag_log format["[%1] Ended, winner %2 runners-up %3",royale_name,name (royale_contenders select 0),royale_death];

		royale_death = nil;

	};

	royale_timer = {
		private["_resize_time","_radius_min","_new_pos"];

		_resize_time = royale_max_time / 5;
		_radius_min	= royale_radius / 5;
		_new_pos = [royale_pos,0,(royale_radius/2),0,0,2000,0] call BIS_fnc_findSafePos;

		diag_log format["[%1] Calculated settings: Resize time %2 - Radius minifier %3",royale_name,(_resize_time - 60),_radius_min];

		for "_i" from 1 to 4 do {
			private["_new_rad"];
			sleep (_resize_time - 60);
			if(!isNil "ROYALE_FINISHED") exitWith {};
			_new_rad = (current_radius - _radius_min);
			_new_pos = [_new_pos,0,_radius_min,0,0,2000,0] call BIS_fnc_findSafePos;
			
			deleteMarker royale_dot;

			royale_temp_marker = createMarker ["royale_temp_marker",_new_pos];

			royale_temp_marker setMarkerColor "ColorYellow";
			royale_temp_marker setMarkerShape "ELLIPSE";
			royale_temp_marker setMarkerBrush "Border";
			royale_temp_marker setMarkerSize [_new_rad,_new_rad];
			royale_temp_marker setMarkerText royale_name;

			royale_dot = createMarker ["royale_dot",_new_pos];
			royale_dot setMarkerColor "ColorRed";
			royale_dot setMarkerType "o_inf";
			royale_dot setMarkerText royale_name;

			RemoteMessage = ["dynamic_text",[royale_name,"Your map has been updated, you have one minute to move to the new area!"]];
			publicVariable "RemoteMessage";
			
			sleep 60;

			deleteMarker royale_temp_marker;
			deleteMarker royale_marker;

			royale_marker = createMarker ["royale_marker",_new_pos];

			royale_marker setMarkerColor "ColorRed";
			royale_marker setMarkerShape "ELLIPSE";
			royale_marker setMarkerBrush "Border";
			royale_marker setMarkerSize [_new_rad,_new_rad];
			royale_marker setMarkerText royale_name;

			current_radius = (current_radius - _radius_min);
			current_pos = _new_pos;
		};

	};

	[_player] spawn {
		private["_notnear"];
		_notnear = true;

		royale_vehicle setVehicleLock "LOCKED";

		{

			if(_x != (_this select 0)) then {
				_x call royale_player_init;
				royale_contenders set[count royale_contenders,_x];
			};
		} forEach crew vehicle (_this select 0);

		clearMagazineCargoGlobal royale_vehicle;
		clearWeaponCargoGlobal royale_vehicle;
		clearBackpackCargoGlobal royale_vehicle;

		royale_total_contenders = count royale_contenders;

		while {_notnear} do {
			sleep 1;
			_pos = getPos royale_vehicle;
			_pos set[2,0];

			if(_pos distance royale_pos < 125) then {
				_notnear = false;
			};
		};

		royale_vehicle setVehicleLock "UNLOCKED";
		sleep .5;

		{
			private["_tmpu","_do"];
			_do = format["if(getPlayerUID player == '%1') then {
				[] spawn {
					player action['eject',(vehicle player)];
					sleep 1;
					player spawn BIS_fnc_halo;
					player setvelocity[0,96,0];
					player setdir 0;
				};
			};",(getPlayerUID _x)];
			_tmpu = createAgent['Rabbit',[2500,2500,0],[],0,'FORM'];
			_tmpu setVehicleInit _do;
			processInitCommands;
			clearVehicleInit _tmpu;
			deleteVehicle _tmpu;
		} count royale_contenders;
	};

	[] spawn {
		private["_num_weapons","_num_items","_marker","_dot"];
		royale_name		= "Skalisty Royale";	// Event name
		royale_pos		= [13620.6,3061.17,0];	// Where does the event take place
		current_pos		= royale_pos;			// Safe pos
		royale_safezone	= [13648.5,3888.39,0];	// Where should players be TP'ed that try and enter event location1
		winner_location	= ["Stary Sobor",[6326.48,7809.48,0]];	// Where should the winner get teleported to after winning
		winner_loottime	= 600;					// How many seconds does the winner get to loot before being teleported to winner_location
		royale_radius	= 680;					// Event radius
		current_radius	= royale_radius;		// Event starting radius
		royale_max_time	= 2700;					// Max time Skalisty should take (in seconds)
		_num_weapons	= 20;					// Number of weapon crate spawns
		_num_items		= 20;					// Number of item crate spawns
		royale_death	= [];					// Keep score of who died when

		for "_i" from 1 to _num_weapons do {
			private["_crate_type","_pos","_crate"];
			_crate_type = crates_small call BIS_fnc_selectRandom;
			_pos = [royale_pos,royale_radius] call royale_find_pos;
			_crate = createVehicle[_crate_type,[(_pos select 0),(_pos select 1),0],[],0,"CAN_COLLIDE"];
			crates set[count crates,[_crate,(floor(round 2) + 1),0] call royale_spawn_crate];
			diag_log format["[Royale] Spawned a weapon crate at %1",_pos];
		};

		for "_i" from 1 to _num_items do {
			private["_crate_type","_pos","_crate"];
			_crate_type = crates_small call BIS_fnc_selectRandom;
			_pos = [royale_pos,royale_radius] call royale_find_pos;
			_crate = createVehicle[_crate_type,[(_pos select 0),(_pos select 1),0],[],0,"CAN_COLLIDE"];
			crates set[count crates,[_crate,0,(floor(round 6) + 2)] call royale_spawn_crate];
			diag_log format["[Royale] Spawned a supply crate at %1",_pos];
		};

		royale_marker = createMarker ["royale_marker",royale_pos];		
		royale_marker setMarkerColor "ColorRed";
		royale_marker setMarkerShape "ELLIPSE";
		royale_marker setMarkerBrush "Border";
		royale_marker setMarkerSize [royale_radius,royale_radius];
		royale_marker setMarkerText royale_name;

		royale_dot = createMarker ["royale_dot",royale_pos];		
		royale_dot setMarkerColor "ColorRed";
		royale_dot setMarkerType "o_inf";
		royale_dot setMarkerText royale_name;

		RemoteMessage = ["dynamic_text",[royale_name,format["Welcome to %1",royale_name]]];
		publicVariable "RemoteMessage";

		sleep 15;

		RemoteMessage = ["dynamic_text",[royale_name,format["We've got a total of %1 players",royale_total_contenders]]];
		publicVariable "RemoteMessage";

		sleep 15;

		RemoteMessage = ["dynamic_text",[royale_name,format["No leaving or coming back! There can be only one winner."]]];
		publicVariable "RemoteMessage";

		sleep 15;

		RemoteMessage = ["dynamic_text",[royale_name,format["Good luck everyone! Let the games begin.",royale_total_contenders]]];
		publicVariable "RemoteMessage";

		[] spawn royale_alive_check;
		[] spawn royale_remove_unwanted;
		[] spawn royale_timer;

	};

};