private["_player_pos","_ownerID","_objects","_i","_ownerID2","_vehicle","_sounddist","_tvih","_nul"];

_ownerID 	= _this select 0;
_sounddist 	= 10;
_player_pos = [player] call FNC_GetPos;

_objects = nearestObjects[_player_pos,["LandVehicle","Helicopter","Plane","Ship"],50];
_i = 0;

{
	_vehicle = _x;
	if(alive _vehicle) then {
		_ownerID2 = _vehicle getVariable["CharacterID","0"];

		if(_ownerID == _ownerID2) then {
			if(locked _vehicle) then {
				if(player distance _vehicle < 50) then {
					DZE_ActionInProgress = true;
					{player removeAction _x} forEach s_player_lockunlock;s_player_lockunlock = [];
					s_player_lockUnlock_crtl = 1;

					PVDZE_veh_Lock = [_vehicle,false];

					if(local _vehicle) then {
						PVDZE_veh_Lock spawn local_lockUnlock;
					} else {
						publicVariable "PVDZE_veh_Lock";
					};

					player action["lightOn",_vehicle];
					_nul = [objNull,_vehicle,rSAY,"carLock",_sounddist] call RE;
					sleep 0.5;
					player action["lightOff",_vehicle];

					_tvih = typeOf _vehicle;
					cutText[format["%1 has been unlocked",_tvih],"PLAIN DOWN"];		

					s_player_lockUnlock_crtl = -1;
					DZE_ActionInProgress = false;
				};
			};
		};

		_i = _i + 1;
	};
} count _objects;

[_vehicle,200,true,([_vehicle] call FNC_GetPos)] spawn player_alertZombies;