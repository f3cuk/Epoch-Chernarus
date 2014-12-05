if(DZE_ActionInProgress) exitWith { cutText[(localize "str_epoch_player_40") ,"PLAIN DOWN"]; };
DZE_ActionInProgress = true;

private["_itemConfig","_classname","_classnametmp","_require","_text","_ghost","_lockable","_requireplot","_isAllowedUnderGround","_offset","_isPole","_isLandFireDZ","_hasRequired","_hasrequireditem","_reason","_buildObject","_location1","_object","_objectHelper","_position","_controls","_cancel","_dir"];

DZE_Q = false;
DZE_Z = false;

DZE_Q_alt = false;
DZE_Z_alt = false;

DZE_Q_ctrl = false;
DZE_Z_ctrl = false;

DZE_5 = false;
DZE_4 = false;
DZE_6 = false;

DZE_F = false;

DZE_cancelBuilding = false;

call gear_ui_init;
closeDialog 1;

DZE_buildItem = _this;

[] call player_build_countNearby;
[] call player_build_states;
[] call player_build_needNearby;

_itemConfig = [] call player_build_getConfig;

if(isNil "_itemConfig") exitWith {
	PVDZE_Log = format["[ERROR] Setup error player %1 (%2)",name player, getPlayerUID player];
	publicVariable "PVDZE_Log";
	cutText["Setup contained errors, booting you to lobby"];
	endMission "END1";
};

_classname 				= _itemConfig select 0;
_classnametmp 			= _itemConfig select 1;
_require 				= _itemConfig select 2;
_text 					= _itemConfig select 3;
_ghost 					= _itemConfig select 4;
_lockable 				= _itemConfig select 5;
_requireplot 			= _itemConfig select 6;
_isAllowedUnderGround 	= _itemConfig select 7;
_offset 				= _itemConfig select 8;
_isPole 				= _itemConfig select 9;
_isLandFireDZ 			= _itemConfig select 10;

[_isPole,_requireplot,_isLandFireDZ] call player_build_plotCheck;

if(DZE_ActionInProgress) then {

	_hasRequired 		= [_require,_text,true,true] call player_build_buildReq;
	_hasrequireditem 	= _hasRequired select 0;

	if(_hasrequireditem) then {

		_buildObject 	= [_classname,_ghost,_offset,true] call player_build_create;
		_location1 		= _buildObject select 0;
		_object 		= _buildObject select 1;
		_objectHelper 	= _buildObject select 2;

		_controls 		= [_object,_isAllowedUnderGround,_location1,_objectHelper] call player_build_controls;

		_cancel 		= _controls select 0;
		_reason 		= _controls select 1;
		_position 		= _controls select 2;
		_dir 			= _controls select 3;

		[_cancel,_position,_classnametmp,_isAllowedUnderGround,_text,_isPole,_lockable,_dir,_reason] call player_build_publish;
	};
};