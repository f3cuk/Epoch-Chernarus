private["_cnt","_pos"];

_pos = [player] call FNC_GetPos;
_cnt = count (_pos nearObjects ["All",DZE_checkNearbyRadius]);

if(_cnt >= DZE_BuildingLimit) exitWith {
	DZE_ActionInProgress = false;
	cutText[(localize "str_epoch_player_41"),"PLAIN DOWN"];
};

_cnt