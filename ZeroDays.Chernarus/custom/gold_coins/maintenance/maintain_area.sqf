private["_maintained","_total_count","_total_damage","_newWealth","_missing","_missingQty","_proceed","_itemIn","_countIn","_target","_objectClasses","_range","_objects","_requirements","_count","_cost","_option","_wealth","_objects_filtered"];

if(DZE_ActionInProgress) exitWith { cutText[(localize "STR_EPOCH_ACTIONS_2") ,"PLAIN DOWN"]; };

DZE_ActionInProgress = true;

player removeAction s_player_maintain_area;
s_player_maintain_area = 1;

player removeAction s_player_maintain_area_preview;
s_player_maintain_area_preview = 1;

_target			= cursorTarget;
_maintained		= _target getVariable["maintained",false];
_objectClasses	= DZE_maintainClasses;
_range			= DZE_maintainRange;
_objects		= nearestObjects[_target,_objectClasses,_range];
_total_count	= count _objects;
_total_damage	= 0;

if(_maintained) exitWith {
	cutText[format["Everything is maintained (total objects %1 - max objects %2)",_total_count,DZE_BuildingLimit],"PLAIN DOWN"];
	DZE_ActionInProgress = false;
	s_player_maintain_area = -1;
	s_player_maintain_area_preview = -1;
};

_objects_filtered = [];
{
	if(damage _x >= DZE_DamageBeforeMaint) then {
		_objects_filtered set[count _objects_filtered,_x];
		_total_damage = _total_damage + damage _x;
	};
} count _objects;

_objects	= _objects_filtered;
_count		= count _objects;

if(_count == 0) exitWith {
	cutText[format["Everything is maintained (total objects %1 - max objects %2)",_total_count,DZE_BuildingLimit],"PLAIN DOWN"];
	DZE_ActionInProgress = false;
	s_player_maintain_area = -1;
	s_player_maintain_area_preview = -1;
};

_total_damage = (_total_damage / _count) + 0.1;

_requirements = [];

call {
	if(_count <= 10)	exitWith { _requirements = [[CurrencyName,round(_total_damage*400)]]; };
	if(_count <= 20)	exitWith { _requirements = [[CurrencyName,round(_total_damage*625)]]; };
	if(_count <= 40)	exitWith { _requirements = [[CurrencyName,round(_total_damage*1250)]]; };
	if(_count <= 80)	exitWith { _requirements = [[CurrencyName,round(_total_damage*2500)]]; };
	if(_count <= 160)	exitWith { _requirements = [[CurrencyName,round(_total_damage*5000)]]; };
	if(_count <= 320)	exitWith { _requirements = [[CurrencyName,round(_total_damage*10000)]]; };
	if(_count <= 640)	exitWith { _requirements = [[CurrencyName,round(_total_damage*20000)]]; };
};

_option = _this select 3;

call {

	if(_option == "maintain") exitWith {
		_wealth		= player getVariable["cashMoney",0];
		_missing	= "";
		_missingQty	= 0;
		_proceed	= true;

		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			if(_wealth < _countIn) exitWith { _missing = _itemIn; _missingQty = (_countIn - _wealth); _proceed = false; };
		} count _requirements;

		if(_proceed) then {
			_newWealth = (_wealth - _countIn);
			player playActionNow "Medic";
			[player,_range,true,([player] call FNC_GetPos)] spawn player_alertZombies;

			player setVariable["cashMoney",_newWealth,true];

			PVDZE_plr_Save = [player,(magazines player),true,true];
			publicVariableServer "PVDZE_plr_Save";

			PVDZE_maintainArea = [player,1,_target];
			publicVariableServer "PVDZE_maintainArea";
			_target setVariable["maintained",true,true];
			cutText[format[(localize "STR_EPOCH_ACTIONS_4"),format["(%1\%2) max %3",_count,_total_count,DZE_BuildingLimit]],"PLAIN DOWN",5];			
		} else {
			cutText[format[(localize "STR_EPOCH_ACTIONS_6"),_missingQty,CurrencyName],"PLAIN DOWN"];
		};
	};

	if(_option == "preview") exitWith {
		_cost = "";
		{
			_itemIn = _x select 0;
			_countIn = _x select 1;
			if(_cost != "") then {
				_cost = _cost + " and ";
			};
			_cost = _cost + (str(_countIn) + " " + CurrencyName);
		} count _requirements;
		cutText[format["%1 of %2 objects need maintainance (~%3 percent damage)\nCosts %4 coins",_count,_total_count,round(_total_damage*100),_cost],"PLAIN DOWN"];
	};
};

DZE_ActionInProgress = false;
s_player_maintain_area = -1;
s_player_maintain_area_preview = -1;