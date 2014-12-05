private["_body","_player_near","_hisMoney","_myMoney"];

_body 			= _this select 3;
_player_near 	= _body call dze_isnearest_player;

if(_player_near) exitWith {cutText[localize "str_pickup_limit_4","PLAIN DOWN"]};

_hisMoney 	= _body getVariable["cashMoney",0];
_myMoney 	= player getVariable["cashMoney",0];

if(typeName _hisMoney == "SCALAR" && typeName _myMoney == "SCALAR") then {

	_myMoney 	= _myMoney + _hisMoney;
	_hisMoney	= [_hisMoney] call BIS_fnc_numberText;

	_body setVariable["cashMoney",0,true];
	player setVariable["cashMoney",_myMoney,true];

	systemChat format['You found %1 coins',_hisMoney];

};