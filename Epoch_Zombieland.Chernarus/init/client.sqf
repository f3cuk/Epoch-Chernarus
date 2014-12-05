private["_nil"];

_nil = [] execVM "custom\remote\remote.sqf";

[] spawn {

	private["_isNew"];

	_isNew = player getVariable["isNew",false];

	execVM "custom\gold_coins\init.sqf";

	if(_isNew) then {
		execVM "custom\welcome_screen\welcome_screen.sqf";
	};
};

[] spawn {

	private["_markers","_color"];

	waitUntil{!isNil "allMarkers"};

	_markers = allMarkers;

	{

		private["_name","_pos","_type"];

		_name	= _x select 0;
		_pos	= _x select 1;
		_type	= _x select 2;

		call {
		
			if(_type == "ellipse") exitWith {

				private["_radius","_marker","_dot"];

				_radius = _x select 3;
				_color	= _x select 4;

				_marker = createMarkerLocal[(_type + _name),_pos];
				_marker setMarkerColorLocal _color;
				_marker setMarkerShapeLocal "ELLIPSE";
				_marker setMarkerBrushLocal "SolidBorder";
				_marker setMarkerSizeLocal[_radius,_radius];
				_marker setMarkerTextLocal _name;

				_dot = createMarkerLocal[("mil_dot" + _name),_pos];
				_dot setMarkerColorLocal _color;
				_dot setMarkerTypeLocal "mil_dot";
				_dot setMarkerTextLocal _name;

			};

			if(_type == "icon") exitWith {

				private["_marker","_icon"];

				_icon = _x select 3;

				_marker = createMarkerLocal[(_type + _name + _icon),_pos];
				_marker setMarkerColorLocal "ColorBlack";
				_marker setMarkerTypeLocal _icon;
				_marker setMarkerTextLocal _name;
			};

		};

	} count _markers;

};