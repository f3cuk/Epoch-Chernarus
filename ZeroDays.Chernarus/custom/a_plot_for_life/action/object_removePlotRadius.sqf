private["_validMarkers","_findNearestPoles","_sphere","_plotpole","_distance"];

_distance = (DZE_PlotPole select 0) + 10;

_plotpole 			= nearestobject [(vehicle player),"Plastic_Pole_EP1_DZ"];
_findNearestPoles 	= nearestObjects[_plotpole,["Sign_sphere100cm_EP1"],_distance];
_validMarkers 		= [];

{
	_sphere = _x getVariable["inventory",[]];

	if(_sphere select 0 == "PPMarker") then {
		_validMarkers set[count _validMarkers,_x];
	};
} count _findNearestPoles;

if(count _validMarkers > 0) then { 
	{
		deleteVehicle _x;
	} count _validMarkers;
};