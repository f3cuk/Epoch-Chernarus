if(!isDedicated) then {
	fn_gearMenuChecks 			= compile preprocessFileLineNumbers "custom\remote_vehicle_unlock\fn_gearMenuChecks.sqf";
	player_selectSlot 			= compile preprocessFileLineNumbers "custom\remote_vehicle_unlock\player_selectSlot.sqf";
	snap_build 					= compile preprocessFileLineNumbers "custom\snap_pro\snap_build.sqf";
	player_death 				= compile preprocessFileLineNumbers "custom\take_clothes\player_death.sqf";

	call compile preprocessFileLineNumbers "custom\mbc\config.sqf";
};