private["_player_pos","_ownerID","_objects","_i","_ownerID2","_vehicle"];

_ownerID 	= _this select 0;
_player_pos = [player] call FNC_GetPos;

_objects = nearestObjects[_player_pos,["LandVehicle","Helicopter","Plane","Ship"],50];
_i = 0;

{
	_vehicle = _x;
	if(alive _vehicle) then {
		_ownerID2 = _vehicle getVariable["CharacterID","0"];

		if(_ownerID == _ownerID2) then {
			if(!locked _vehicle) then {
				if(player distance _vehicle < 50) then {
					DZE_ActionInProgress = true;

					if(isEngineOn _vehicle) then {
						_vehicle engineOn false;
					} else {
						_vehicle engineOn true;
					};

					DZE_ActionInProgress = false;
				};
			};
		};

		_i = _i + 1;
	};
} count _objects;