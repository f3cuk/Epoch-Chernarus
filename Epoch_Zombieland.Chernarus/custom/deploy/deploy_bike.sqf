private["_dist","_dir","_pos","_veh","_canDeployBike"];

_canDeployBike = player getvariable["canDeployBike",true];

if(_canDeployBike) then {

	CanDeployBike = false;
	player setVariable["canDeployBike",false];
	player removeWeapon "ItemToolbox";

	_dist 	= 5;
	_dir 	= getDir vehicle player;
	_pos 	= [player] call FNC_GetPos;
	_pos 	= [(_pos select 0)+_dist*sin(_dir),(_pos select 1)+_dist*cos(_dir),0];

	_veh = createVehicle["Old_bike_TK_CIV_EP1",_pos,[],0,"CAN_COLLIDE"];
	_veh setVariable["MalSar",1,true];
	_veh setVariable["ObjectID","1",true];
	_veh setVariable["ObjectUID","1",true];
	clearMagazineCargoGlobal _veh;
	clearWeaponCargoGlobal _veh;

	cutText["You have built a bike!\nNote: Bikes get removed on restart!","PLAIN DOWN",3];

	[] spawn {

		sleep 600;
		player setVariable["canDeployBike",true];
	};

} else {

	cutText["You can only spawn one bike every 10 minutes","PLAIN DOWN",3];	

};