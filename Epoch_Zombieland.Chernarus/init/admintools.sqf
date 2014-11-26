waitUntil {!isNil "adminListLoaded"}; // Wait for adminlist before starting
waitUntil {!isNil "dayz_animalCheck"}; // Wait for the character to load all required items

// Give admins the admin menu
if ((getPlayerUID player) in AdminAndModList) then {
	[] spawn {
		private["_idx","_player","_veh"];

		_idx 	= -1;
		_player = player;
		_veh 	= vehicle _player;

		// Load key macros
		[] execVM "admintools\keybindings.sqf";
		
		// Tool use logger
		if(logMajorTool || logMinorTool) then {
			usageLogger = format["%1 %2 -- has logged on",name _player,getPlayerUID _player];
			[] spawn {publicVariable "usageLogger";};
		};

		while {alive _player} do
		{
			if(toolsAreActive) then
			{
				if (_idx == -1) then
				{
					_idx = (vehicle _player) addaction [("<t color=""#585858"">" + ("Admin Menu") +"</t>"),"admintools\init.sqf","",7,false,true,"",""];
					_veh = vehicle _player;
				};
				if (_veh != vehicle _player) then
				{
					_veh removeAction _idx;
					_idx = -1;      
				};
			} else {
				if(_idx != -1) then {
					_veh removeAction _idx;
					_idx = -1;
				};
			};
			sleep 2;
		};
		
		_veh removeAction _idx;
		_idx = -1;
	};
} else {
	execVM "admintools\antihack\antihack.sqf";	
};