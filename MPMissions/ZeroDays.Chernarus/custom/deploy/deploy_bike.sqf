if(isNil "canDeployBike") then {

	if(!isNil "hasSpawnedBike") then {

		if((getPlayerUID player) in hasSpawnedBike) then {
			canDeployBike = false;
		} else {
			canDeployBike = true;
		};

	} else {
		canDeployBike = true;
	};

};

if(canDeployBike) then {

	private["_dist","_dir","_pos","_veh"];

	canDeployBike = false;

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

	cutText["You have built a bike! Note: Bikes get removed on restart.","PLAIN DOWN",3];

	PVDZE_deploy_bike = [getPlayerUID player];
	publicVariableServer "PVDZE_deploy_bike";

} else {

	cutText["You can only build one bike each restart","PLAIN DOWN",3];	

};