private ["_dp"];

disableSerialization;

if ((getPlayerUID player) in AdminList || (getPlayerUID player) in ModList) then {
	
	waitUntil {!isNil "dayz_animalCheck"};
		
	fn_functionkeys = {

		private["_key_pressed"];

		_key_pressed = _this;

		if(typeName _key_pressed == "SCALAR") then {

			call {
				if(_key_pressed == 59) exitWith { execVM "admintools\tools\Teleport\Teleport.sqf"; };
				if(_key_pressed == 60) exitWith { execVM "admintools\tools\Teleport\TPtoME.sqf"; };
				if(_key_pressed == 61) exitWith { execVM "admintools\tools\Teleport\TpToPlayer.sqf"; };
				if(_key_pressed == 65) exitWith { execVM "admintools\tools\DatabaseRemove.sqf"; };
				if(_key_pressed == 66) exitWith { execVM "admintools\tools\PointToRepairPERM.sqf"; };
				if(_key_pressed == 67) exitWith { execVM "admintools\tools\gimmecode.sqf"; };
				if(_key_pressed == 68) exitWith { if(toolsAreActive) then { toolsAreActive = false; } else { toolsAreActive = true; }; _execvm = false;  };
				if(_key_pressed == 87) exitWith { execVM "admintools\tools\vehicleLocator.sqf"; };
			};

		};
	};

	(findDisplay 46) displayAddEventHandler ["KeyDown","(_this select 1) call fn_functionkeys"];

	diag_log("Admin Tools: FunctionKeys.sqf Loaded");
};