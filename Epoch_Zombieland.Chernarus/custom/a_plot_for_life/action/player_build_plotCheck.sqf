if(!DZE_ActionInProgress) exitWith {};

private["_passArray","_isPole","_needText","_distance","_findNearestPoles","_findNearestPole","_IsNearPlot","_requireplot","_isLandFireDZ","_canBuildOnPlot","_nearestPole","_ownerID","_friendlies","_playerUID"];

_isPole 		= _this select 0;
_requireplot 	= _this select 1;
_isLandFireDZ	= _this select 2;

_needText 		= localize "str_epoch_player_246";
_canBuildOnPlot = false;
_nearestPole 	= objNull;
_ownerID 		= 0;
_friendlies 	= [];

if(_isPole) then {
	_distance = DZE_PlotPole select 1;
} else {
	_distance = DZE_PlotPole select 0;
};

_findNearestPoles	= nearestObjects[(vehicle player),["Plastic_Pole_EP1_DZ"],_distance];
_findNearestPole	= [];

{
	if(alive _x) then {
		_findNearestPole set[(count _findNearestPole),_x];
	};
} count _findNearestPoles;

_IsNearPlot = count (_findNearestPole);

if(_IsNearPlot == 0) then {

	if(_requireplot == 0 || _isLandFireDZ) then {
		_canBuildOnPlot = true;
	};

} else {

	_nearestPole = _findNearestPole select 0;

	if(DZE_APlotforLife) then {
		_playerUID = [player] call FNC_GetPlayerUID;
	} else {
		_playerUID = dayz_characterID;
	};

	_ownerID = _nearestPole getVariable["ownerPUID","0"];

	if(_playerUID == _ownerID) then { 

		if(!_isPole) then {
			_canBuildOnPlot = true;
		};
	} else {

		if(!_isPole) then {
			_friendlies		= player getVariable["friendlyTo",[]];

			if(_ownerID in _friendlies) then {
				_canBuildOnPlot = true;
			};
		};
	};
};

_passArray = [_IsNearPlot,_nearestPole,_ownerID,_friendlies];

if(_isPole && _IsNearPlot > 0) exitWith { 
	DZE_ActionInProgress = false;
	cutText[(format[localize "str_epoch_player_44",DZE_PlotPole select 1]) ,"PLAIN DOWN"];
	_passArray
};

if(!_canBuildOnPlot) exitWith {
	DZE_ActionInProgress = false;
	cutText[format[(localize "STR_EPOCH_PLAYER_135"),_needText,_distance] ,"PLAIN DOWN"];
	_passArray
};

_passArray