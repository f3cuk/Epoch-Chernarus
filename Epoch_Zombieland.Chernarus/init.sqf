if(!isDedicated) then {
	startLoadingScreen ["","RscDisplayLoadCustom"];
	cutText["","BLACK OUT"];
	enableSaving [false,false];
	player setVariable["BIS_noCoreConversations",true];
	enableRadio true;
	enableSentences false;
	preload_done = false;
};

#include "config\config.sqf"

call compile preprocessFileLineNumbers "init\variables.sqf";
progressLoadingScreen 0.1;
call compile preprocessFileLineNumbers "init\publicEH.sqf";
progressLoadingScreen 0.2;
call compile preprocessFileLineNumbers "\z\addons\dayz_code\medical\setup_functions_med.sqf";
progressLoadingScreen 0.4;
call compile preprocessFileLineNumbers "init\compiles.sqf";
progressLoadingScreen 0.5;
call compile preprocessFileLineNumbers "server_traders.sqf";
progressLoadingScreen 0.7;
call compile preprocessFileLineNumbers "custom\compiles.sqf";
progressLoadingScreen 1.0;

"filmic" setToneMappingParams [0.153,0.357,0.231,0.1573,0.011,3.750,6,4];
setToneMapping "filmic";

if(isServer) then {
	execVM "\z\addons\dayz_server\missions\Epoch_Zombieland.Chernarus\traders.sqf";
	execVM "\z\addons\dayz_server\missions\Epoch_Zombieland.Chernarus\init.sqf";
	execVM "\z\addons\dayz_server\system\custom\server_monitor.sqf";
};

if(!isDedicated) then {
	0 fadeSound 0;

	waitUntil {(!isNil "sm_done" && !isNil "init_done" && !isNil "dayz_loadScreenMsg")};
		diag_log format["%1: Server done loading",servertime];
	
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");

	waitUntil {(!isNil "allObjects" && !isNil "localObjects")};
		diag_log format["%1: Epoch buildables and map add-ons received",servertime];

	call compile preprocessFileLineNumbers "init\objects.sqf";

	waitUntil {(epochObjectsLoaded && missionObjectsLoaded)};
		diag_log format["%1: Epoch buildables and mision objects loaded",servertime];

	player addEventhandler["Respawn",{_id = [] spawn player_death;}];
	execVM "custom\character_select\player_monitor.sqf";

	waitUntil {!isNil "dayz_clientPreload"};
		diag_log format["%1: dayz_clientPreload has started",servertime];
	waitUntil {dayz_clientPreload};
		diag_log format["%1: dayz_clientPreload is done",servertime];
	waitUntil {!isNil "allMarkers"};
		diag_log format["%1: Markers received from server",servertime];

	execVM "init\client.sqf";

	if(DIFF in ["VETERAN","REGULAR"]) then {
		execVM "custom\safezone\safezone.sqf";
	};

	preload_done = true;
};

execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"