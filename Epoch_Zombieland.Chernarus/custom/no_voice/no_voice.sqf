[] spawn {
	
    private ["_txt1","_txt2","_txtchk1","_display1","_display2","_detectedChannels"];
    
    disableSerialization;

   _detectedChannels = ["Side channel"];

	while {true} do
	{
		_display1 = findDisplay 55;
		_display2 = findDisplay 63;
 
		if ( (!isNull _display1) AND (!isNull _display2) ) then {
			_txt1 = ctrlText ((findDisplay 55) displayCtrl 101);
			_txt2 = ctrlText ((findDisplay 63) displayCtrl 101);
	 
			_txtchk1 = "\ca\ui\textures\mikrak.paa";
	 
			if ( (_txt1 == _txtchk1) AND (_txt2 in _detectedChannels) ) then {
				cutText["Warning: DO NOT TALK IN SIDE","WHITE IN"];
			};
		};
	 
		sleep 2;
	};
};