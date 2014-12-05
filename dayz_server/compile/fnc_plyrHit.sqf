private["_victim","_vehicle"];

_victim = _this select 0;

if(isPlayer _victim) then {

	private["_attacker","_weapon","_distance","_damage"];

	_attacker 	= _this select 1;
	_damage 	= _this select 2;

	if((owner _victim) == (owner _attacker)) exitWith {
		_victim setVariable["AttackedBy",_victim];
	};

	_weapon = weaponState _attacker;

	if(!isNil "_weapon") then {

		if(count _weapon != 0) then {
			if(_weapon select 0 == "Throw") then {
				_weapon = _weapon select 3;
			} else {
				_weapon = _weapon select 0;
			};
		};

	};

	if(isNil "_weapon") then {

		_vehicle = typeOf (vehicle _attacker);

		if(!isNil "_vehicle") then {
			_weapon = getText (configFile >> "CfgVehicles" >> _vehicle >> "displayName");
		} else {
			_weapon = "an unknown weapon";
		};
	};

	_distance = _victim distance _attacker;

	diag_log format["PHIT: %1 was hit by %2 with %3 from %4m with %5 dmg",name _victim,name _attacker,_weapon,_distance,_damage];

	_victim setVariable["AttackedBy",_attacker];
	_victim setVariable["AttackedByName",(name _attacker)];
	_victim setVariable["AttackedByWeapon",_weapon];
	_victim setVariable["AttackedFromDistance",_distance];

};