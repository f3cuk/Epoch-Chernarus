if (!isDedicated) then {
	startLoadingScreen ["","RscDisplayLoadCustom"];
	cutText ["","BLACK OUT"];
	enableSaving [false,false];
	player setVariable ["BIS_noCoreConversations",true];
	enableRadio true;
	enableSentences false;
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

if (isServer) then {
	_nil = execVM "\z\addons\dayz_server\missions\Epoch_Zombieland.Chernarus\traders.sqf";
	_nil = execVM "\z\addons\dayz_server\missions\Epoch_Zombieland.Chernarus\init.sqf";
	_serverMonitor = execVM "\z\addons\dayz_server\system\custom\server_monitor.sqf";
};

if (!isDedicated) then {
	0 fadeSound 0;

	waitUntil {sleep .5; !isNil "init_done"};
	waitUntil {sleep .5; !isNil "sm_done"};
	waitUntil {sleep .5; !isNil "dayz_loadScreenMsg"}; // stop doing anything until the server is done loading
	dayz_loadScreenMsg = (localize "STR_AUTHENTICATING");

	_id = player addEventHandler ["Respawn", {_id = [] spawn player_death;}];
	_playerMonitor = execVM "custom\character_select\player_monitor.sqf";

	waitUntil {sleep .5; !isNil "dayz_clientPreload"};
	waitUntil {sleep .5; dayz_clientPreload}; // wait until the client is properly setup

	waitUntil {sleep .5; !isNil "allMarkers"};
	waitUntil {sleep .5; !isNil "allObjects"};
	waitUntil {sleep .5; !isNil "localObjects"};
	#include "init\client.sqf"

	waitUntil {sleep .5; !isNil "objectsLoaded"};

	call compile preprocessFileLineNumbers "admintools\config.sqf";
	call compile preprocessFileLineNumbers "admintools\variables.sqf";

	waitUntil {sleep .5; !isNil "adminListLoaded"};
	waitUntil {sleep .5; ((!isNil "spawnedLoaded") && (spawnedLoaded))};

	if(DIFF in ["VETERAN","REGULAR"]) then {
		execVM "custom\safezone\safezone.sqf";
	};

	execVM "init\admintools.sqf";
};

#include "\z\addons\dayz_code\system\REsec.sqf"
execVM "\z\addons\dayz_code\external\DynamicWeatherEffects.sqf";
#include "\z\addons\dayz_code\system\BIS_Effects\init.sqf"