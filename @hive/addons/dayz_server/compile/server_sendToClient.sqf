private["_unit","_variable","_arraytosend","_owner","_vehicle","_qty"];

_unit = _this select 0;

if(isNull _unit) exitWith {diag_log format["ERROR: sendToClient is Null: %1",_unit]};

_variable		= _this select 1;
_arraytosend	= _this select 2;
_owner			= owner _unit;

call {

	if(_variable == "VehHandleDam") exitWith {
		_vehicle = _arraytosend select 0;
		if(local _vehicle) then {
			_arraytosend call fnc_veh_handleDam;
		} else {
			PVCDZE_vehSH = _arraytosend;
			_owner publicVariableClient "PVCDZE_vehSH";
		};
	};

	if(_variable == "SFuel") exitWith {
		_vehicle = _arraytosend select 0;
		_qty = _arraytosend select 1;
		if(local _vehicle) then {
			_vehicle setFuel _qty;
		} else {
			PVDZE_veh_SFuel = _arraytosend;
			_owner publicVariableClient  "PVDZE_veh_SFuel";
		};
	};

	if(_variable == "HideBody") exitWith {
		PVDZE_plr_HideBody = _arraytosend select 0;
		_owner publicVariableClient "PVDZE_plr_HideBody";
	};

	if(_variable == "Humanity") exitWith {
		PVDZE_plr_HumanityChange = _arraytosend;
		_owner publicVariableClient "PVDZE_plr_HumanityChange";
	};

	if(_variable == "PZ_BreakLegs") exitWith {
		usecBreakLegs = _arraytosend;
		_owner publicVariableClient "usecBreakLegs";
	};

	if(_variable == "Bleed") exitWith {
		usecBleed = _arraytosend;
		_owner publicVariableClient "usecBleed";
	};

	if(_variable == "HideObj") exitWith {
		PVDZE_obj_Hide = _arraytosend select 0;
		_owner publicVariableClient "PVDZE_obj_Hide";
	};

	if(_variable == "RoadFlare") exitWith {
		PVDZE_obj_RoadFlare = _arraytosend;
		_owner publicVariableClient "PVDZE_obj_RoadFlare";
	};

	if(_variable == "Transfuse") exitWith {
		usecTransfuse = _arraytosend;
		_owner publicVariableClient "usecTransfuse";
		_unit setVariable["medForceUpdate",true];
	};

	if(_variable == "Painkiller") exitWith {
		usecPainK = _arraytosend;
		_owner publicVariableClient "usecPainK";
		_unit setVariable["medForceUpdate",true];
	};

	if(_variable == "Morphine") exitWith {
		usecMorphine = _arraytosend;
		_owner publicVariableClient "usecMorphine";
		_unit setVariable["hit_legs",0,false];
		_unit setVariable["hit_hands",0,false];
		_unit setVariable["medForceUpdate",true];
	};

	if(_variable == "Epinephrine") exitWith {
		usecEpi = _arraytosend;
		_owner publicVariableClient "usecEpi";
		_unit setVariable["medForceUpdate",true];
	};

	if(_variable == "Bandage") exitWith {
		usecBandage = _arraytosend;
		_owner publicVariableClient "usecBandage";
		_unit setVariable["medForceUpdate",true];
	};

	if(_variable == "tagFriendly") exitWith {
		PVDZE_plr_FriendRQ = _arraytosend;
		_owner publicVariableClient "PVDZE_plr_FriendRQ";
	};
};