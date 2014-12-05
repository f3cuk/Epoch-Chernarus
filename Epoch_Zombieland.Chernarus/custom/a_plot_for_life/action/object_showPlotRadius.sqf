private["_nearPlotPole","_BD_radius","_BD_center"];

_nearPlotPole = nearestObject [player,"Plastic_Pole_EP1_DZ"];

_BD_radius = DZE_PlotPole select 0;
_BD_center = getPosASL _nearPlotPole;

[_BD_radius,_BD_center] spawn {
	private["_angle","_count","_radius","_center"];

	_radius		= _this select 0;
	_center		= _this select 1;

	_angle 		= 0;	
	_count 		= round((2 * pi * _radius) / 4);

	for "_x" from 0 to _count do
	{
		private["_a","_b","_obj"];

		_a = (_center select 0) + (sin(_angle)*_radius);
		_b = (_center select 1) + (cos(_angle)*_radius);

		_obj = "Sign_sphere100cm_EP1" createVehicleLocal[0,0,0];
		_obj setPosASL [_a,_b,_center select 2];
		_obj setVariable["Inventory",["PPMarker"],true];
		_angle = _angle + (360/_count);
	};

	for "_x" from 0 to _count do
	{
		private["_a","_b","_obj"];

		_a = (_center select 0) + (sin(_angle)*_radius);
		_b = (_center select 2) + (cos(_angle)*_radius);

		_obj = "Sign_sphere100cm_EP1" createVehicleLocal[0,0,0];
		_obj setPosASL [_a,_center select 1,_b];
		_obj setVariable["Inventory",["PPMarker"],true];
		_angle = _angle + (360/_count);
	};

	for "_x" from 0 to _count do
	{
		private["_a","_b","_obj"];

		_a = (_center select 1) + (sin(_angle)*_radius);
		_b = (_center select 2) + (cos(_angle)*_radius);

		_obj = "Sign_sphere100cm_EP1" createVehicleLocal[0,0,0];
		_obj setPosASL [_center select 0,_a,_b];
		_obj setVariable["Inventory",["PPMarker"],true];
		_angle = _angle + (360/_count);
	};
};