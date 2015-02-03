private["_traders","_unit"];

_traders = [
	["RU_Functionary1",[12946.349,12766.593,2.09],194],
	["Woodlander1",[11471.179,11361.226,-9.15],250],
	["RU_WorkWoman1",[11463.931,11351.671,0.94],261],
	["Rocker4",[11465.548,11354.459],310],
	["RU_Citizen3",[11462.307,11365.972,3.05],125],
	["Dr_Annie_Baker_EP1",[11472.008,11370.638],208],
	["TK_CIV_Takistani04_EP1",[6321.0005,7794.4478,0.98],359],
	["Pilot_EP1",[6317.0498,7797.918,-0.28],464],
	["Rita_Ensler_EP1",[6310.7803,7794.5054,0.88],-114],
	["Worker2",[12061.648,12636.292,0.020880492],20],
	["GUE_Soldier_MG",[1623.1722,7797.7886,0.25734121],274],
	["RU_Profiteer4",[6300.312,7800.5874,-0.034530878],-49],
	["Woodlander3",[6317.9883,7789.3345,3.0517578e-005],-130],
	["HouseWife1",[13468.382,5439.5752,2.8821261],-91],
	["Doctor",[4059.437,11660.436],24],
	["Worker3",[4041.6206,11668.891,0.23954971],24],
	["CIV_EuroMan01_EP1",[4064.0681,11680.065,-0.038146973],231],
	["RU_WorkWoman5",[4071.9915,11676.731,0.54440308],566],
	["TK_CIV_Worker01_EP1",[4054.218,11664.668,-0.51617432],422],
	["CIV_EuroMan02_EP1",[4058.0457,11678.723,0.33944702],90],
	["Dr_Hladik_EP1",[6314.0962,7791.5308,0.51730686],577],
	["Profiteer4",[11449.484,11341.03,-9.1552734e-005],34],
	["RU_Villager3",[7996.1021,2899.0759,0.6355527],86],
	["Policeman",[6321.0439,7781.0288],10],
	["Haris_Press_EP1",[9941.3555,5448.8511,1.52],388],
	["CIV_EuroWoman01_EP1",[9894.2783,5474.5215],152],
	["Citizen2_EP1",[9921.7402,5430.4819],288],
	["Profiteer1",[8071.98,3381.31,2.57],240]
];

{
	_unit = createAgent [(_x select 0),(_x select 1),[],0,"CAN_COLLIDE"];
	{
		_unit removeMagazine _x;
	} count magazines _unit;
	removeAllWeapons _unit;
	_unit switchMove "";
	_unit setDir (_x select 2);
	_unit setUnitAbility 0.60000002;
	_unit allowDammage false;
	_unit setVehicleInit "this allowDammage false; this disableAI 'FSM'; this disableAI 'MOVE'; this disableAI 'AUTOTARGET'; this disableAI 'TARGET'; this setBehaviour 'CARELESS'; this forceSpeed 0;";
	_unit disableAI 'FSM';
	_unit disableAI 'MOVE';
	_unit disableAI 'AUTOTARGET';
	_unit disableAI 'TARGET';
	_unit setBehaviour 'CARELESS';
	_unit forceSpeed 0;
	_unit enableSimulation false;
	processInitCommands;
} forEach _traders;