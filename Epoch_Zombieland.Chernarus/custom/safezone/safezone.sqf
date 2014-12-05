waitUntil { !isNil 'dayz_animalCheck' };

if(isNil "inSafeZone") then { inSafeZone = false; } else { if(typename inSafeZone != 'BOOL') then { inSafeZone = false; }; };

[] spawn {

	private["_safezones","_state","_z","_r","_startSafeZone","_endSafeZone"];

	_safezones = [
		[[6325.6772,7807.7412],100],
		[[4063.4226,11664.19],100],
		[[11447.472,11364.504],100],
		[[1606.6443,7803.5156],75],
		[[12944.227,12766.889],75],
		[[12060.471,12638.533],75],
		[[9908.5,5446.78],75],
		[[8071.98,3381.31],50]
	];

	{
		private["_angle","_count","_radius","_center"];

		_center	= _x select 0;
		_radius	= _x select 1;
		_angle	= 0;	
		_count	= round((2 * pi * _radius) / 8);

		for "_x" from 0 to _count do
		{

			private["_a","_b","_obj"];

			_a = (_center select 0) + (sin(_angle)*_radius);
			_b = (_center select 1) + (cos(_angle)*_radius);

			_obj = "Sign_sphere100cm_EP1" createVehicleLocal[0,0,0];
			_obj setPosATL [_a,_b,0];
			_angle = _angle + (360/_count);
		};
	} forEach _safezones;

	_startSafeZone = {

		private["_msg","_szs","_swep","_item","_iPos","_radius","_removed","_veh","_notInSafeZone","_cwep"];

		if(isNil 'outNow') then {

			_msg = 'You entered a Safe Zone!';
			hint _msg;
			taskHint [_msg,[0,1,0,1],'taskDone'];
			inNow = nil;
			outNow = true;
		};

		player_fired2 = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_fired.sqf';
		player_fired = {
			_this call player_fired2;
			deleteVehicle (nearestObject [_this select 0,_this select 4]);
			cutText['You can not fire in a SafeZone!','WHITE IN'];
		};
		fnc_usec_damageHandler = {};
		player removeAllEventHandlers 'handleDamage';
		player addEventhandler['handleDamage',{false}];
		player allowDamage false;
		_veh = vehicle player;
		if(player != _veh) then
		{
			_szs = _veh getVariable['inSafeZone',0];

			if(_szs == 0) then
			{
				_veh removeAllEventHandlers 'Fired';
				_veh addEventhandler['Fired',{_this call player_fired;}];
				{
					_x removeAllEventHandlers 'Fired';
					_x addEventhandler['Fired',{_this call player_fired;}];
				} count (crew _veh);

				_veh setVariable['inSafeZone',1,true];
				_veh removeAllEventHandlers 'HandleDamage';
				_veh addEventhandler['HandleDamage',{false}];
				_veh allowDamage false;
			};
		};
		_notInSafeZone = ['MAAWS','RPG7V','M136','RPG18','STINGER','MeleeHatchet_DZE','MeleeHatchet','MeleeCrowbar','MeleeMachete','MeleeFishingPole','MeleeSledge','MeleeBaseBallBatNails','MeleeBaseBallBatBarbed','MeleeBaseBallBat'];
		_cwep = currentWeapon player;

		if(_cwep in _notInSafeZone) then
		{
			_swep = '';
			{
				if((getNumber (configFile >> 'CfgWeapons' >> _x >> 'Type')) == 2) exitWith
				{
					_swep = _x;
				};
			} count (weapons player);

			if(_swep == '') then
			{
				player playActionNow 'PutDown';
				_iPos = [player] call FNC_GetPos;
				_radius = 1;
				_removed = ([player,_cwep,1] call BIS_fnc_invRemove);
				if(_removed == 1) then
				{
					_item = createVehicle['WeaponHolder',_iPos,[],_radius,'CAN_COLLIDE'];
					_item addWeaponCargoGlobal [_cwep,1];
				};
			}
			else
			{
				player selectweapon _swep;
			};
		};
	};
	_endSafeZone = {

		private["_msg","_szs","_end","_veh"];

		if(isNil 'inNow') then {

			if(str fnc_usec_damageHandler == '{}') then {
				_msg = 'You left the Safe Zone!';
				hint _msg;
				taskHint [_msg,[1,0,0.1,1],'taskFailed'];
			};

			inNow = true;
			outNow = nil;
		};

		player_fired = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_fired.sqf';
		player_zombieCheck = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\player_zombieCheck.sqf';
		fnc_usec_unconscious = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_unconscious.sqf';
		object_monitorGear = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\object_monitorGear.sqf';

		_veh = vehicle player;
		if(player != _veh) then
		{
			_szs = _veh getVariable['inSafeZone',0];
			if(_szs == 1) then
			{
				_veh setVariable['inSafeZone',0,true];
				_veh removeAllEventHandlers 'HandleDamage';
				_veh addeventhandler['HandleDamage',{ _this call vehicle_handleDamage } ];
				_veh allowDamage true;
			};
		};

		_end = false;
		if(isNil 'gmadmin') then
		{
			_end = true;
		}
		else
		{
			if(gmadmin == 0) then
			{
				_end = true;
			};
		};
		if(_end) then
		{
			player allowDamage true;
			fnc_usec_damageHandler = compile preprocessFileLineNumbers '\z\addons\dayz_code\compile\fn_damageHandler.sqf';
			player removeAllEventHandlers 'HandleDamage';
			player addeventhandler['HandleDamage',{_this call fnc_usec_damageHandler;} ];
		};
	};

	while {true} do {
		if(isNil 'inSafeZone') then { inSafeZone = false; } else { if(typename inSafeZone != 'BOOL') then { inSafeZone = false; }; };
		_state = false;

		{
			_z = _x select 0;
			_r = _x select 1;
			if((vehicle player) distance _z < _r) then {_state = true;};
		} count _safezones;

		if(_state) then
		{

			inSafeZone = true;

			call _startSafeZone;

			{
				if(!isNull _x) then
				{
					if !(isPlayer _x) then
					{
						deletevehicle _x;
					};
				};
			} count ((vehicle player) nearEntities ['zZombie_Base',15]);

		}
		else
		{
			inSafeZone = false;
		};

		uiSleep 2;

		if(!inSafeZone) then
		{
			call _endSafeZone;
		};
	};
};

[] spawn {

	private["_log","_cnt"];

	while {true} do
	{
		if(inSafezone) then
		{
			_cnt = {isPlayer _x && _x != player} count (player nearEntities [['CAManBase'],3]);
			if((_cnt > 0) && (!isNull (findDisplay 106))) then
			{
				(findDisplay 106) closedisplay 0;
				closeDialog 0;
				_log = format['%1 You are not allowed to open gear while near another player',name player];
				cutText[_log,'PLAIN'];
				hint _log;
			};
		}
		else
		{
			uiSleep 2;
		};
		uiSleep 0.1;
	};
};