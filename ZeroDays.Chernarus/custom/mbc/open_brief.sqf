disableSerialization;

private["_slots","_type","_item","_spawnCrate","_crateName","_pos","_crateClass","_dir","_selectDelay","_inVehicle"];

_type = _this select 0;

call {

	if(_type == "Premium") exitWith {
		_slots = 6; 
		_item = "ItemBriefcase_Base";
	};

	if(_type == "Silver") exitWith {
		_slots = 3;
		_item = "ItemSilvercase_Base";
	};
};

(findDisplay 106) closedisplay 0;
closeDialog 0;

_inVehicle = (vehicle player) != player;
if(_inVehicle) exitWith {
	cutText[format["You cannot open %1 in a vehicle.",MBT_NAME],"PLAIN DOWN"];
};

cutText[format["Opening EpochPack %1 (%2 items)..",_type,_slots],"PLAIN DOWN"];
player playActionNow "Medic";

r_interrupt = false;
_animState = animationState player;
r_doLoop = true;
_started = false;
_finished = false;
_briefSoundPlay = false;
_briefSoundCount = 0;

while {r_doLoop} do {
	_animState = animationState player;
	_isMedic = ["medic",_animState] call fnc_inString;
	_briefSoundCount = _briefSoundCount + 1;
	if(_briefSoundCount > 10 && !_briefSoundPlay) then { //Just to delay the sound a bit
		[objNull,player,rSAY,"Brief_Open_Sound",30] call RE;
		_briefSoundPlay = true;
	};
	if(_isMedic) then {
		_started = true;
	};
	if(_started and !_isMedic) then {
		r_doLoop = false;
		_finished = true;
	};
	if(r_interrupt) then {
		r_doLoop = false;
	};
	sleep 0.1;
};
r_doLoop = false;

if(!_finished) exitWith { 
	r_interrupt = false;
	if(vehicle player == player) then {
		[objNull,player,rSwitchMove,""] call RE;
		player playActionNow "stop";
	};
	cutText[format["Cancelled opening.."],"PLAIN DOWN"];
};

if(_finished) then {

	private["_dialog","_cashToAdd","_canContinue"];
	mbc_rewardlist_temp = [];
	_canContinue = false;

	if(_item in magazines player) then {
		player removeMagazine _item;
		_canContinue = true;
	};

	if(!_canContinue) exitWith { //Anti-duping
		cutText[format["Opening EpochPack %1 failed.",_type] ,"PLAIN DOWN"];
	};

	_crateClass = "USOrdnanceBox";

	_dir = getdir player;
	_pos = [player] call FNC_GetPos;
	_pos = [(_pos select 0)+1*sin(_dir),(_pos select 1)+1*cos(_dir),(_pos select 2)];

	_spawnCrate = _crateClass createVehicleLocal _pos;

	_spawnCrate setDir _dir;
	_spawnCrate setPosATL _pos;

	clearWeaponCargoGlobal _spawnCrate;
	clearMagazineCargoGlobal _spawnCrate;
	clearBackpackCargoGlobal _spawnCrate;

	_lootRandomizer = [];

	//Let's crate an array to randomize loot depending on rarity
	{
		private["_forEachTempIndexNo"];
		_forEachTempIndexNo = _forEachIndex;
		for "_i" from 1 to (_x select 4) do {
			_lootRandomizer set[count _lootRandomizer,_forEachTempIndexNo];
		};
	} forEach MBC_REWARDLIST;

	Sleep 0.2;

	for "_i" from 1 to _slots do {
		private["_loot","_lootIndex","_lootType"];
		_loot 		= [];
		_lootIndex	= _lootRandomizer call BIS_fnc_selectRandom;
		_loot		= + MBC_REWARDLIST;
		_loot		= _loot select _lootIndex;
		_lootType	= _loot select 0;

		//Let's pick the random items out of groups right away,so we can properly display it on the UI
		call {
			if(_lootType == "group_wep") exitWith {
				_groupingArray = _loot select 1;
				_weapon = _groupingArray call BIS_fnc_selectRandom;
				_loot set[1,_weapon]; // Random weapon
				_loot set[2,(1 + floor(random 4))]; // Random amount of mags
			};
			if(_lootType == "group_tool") exitWith  {
				_groupingArray = _loot select 1;
				_tool = _groupingArray call BIS_fnc_selectRandom;
				_loot set[1,_tool]; // Random tool
			};
			if(_lootType == "group_mag") exitWith {
				_mag = (_loot select 1) call BIS_fnc_selectRandom;
				_loot set[1,_mag]; // Random item
			};
		};
		mbc_rewardlist_temp set[count mbc_rewardlist_temp,_loot];
		_loot = [];
	};

	UpdateMBCDialog = {
		{
			private["_pic","_text","_itemName","_qty","_addInfo","_className","_type","_rarity"];

			ctrlSetText[81401,MBT_DIALOG_TITLE];
			ctrlSetText[81402,MBT_DIALOG_CLAIM];
			ctrlSetText[81403,MBT_DIALOG_NOTE];

			_addInfo	= "";
			_type		= _x select 0;

			call {
				if(_type == "group_wep") exitWith {
					_pic = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'picture');
					_itemName = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'displayName');
					_qty = _x select 2;
					_text = format["%1\n+%2 magazines",_itemName,_qty];
				};
				if(_type == "group_tool") exitWith {
					_pic = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'picture');
					_itemName = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'displayName');
					_text = format["%1",_itemName];
				};
				if(_type == "group_mag") exitWith {
					_pic = getText (configFile >> 'CfgMagazines' >> _x select 1 >> 'picture');
					_itemName = getText (configFile >> 'CfgMagazines' >> _x select 1 >> 'displayName');
					_qty = _x select 2;
					if(_qty > 1) then {
						_addInfo = format["\nx %1",_qty];
					};
					_text = format["%1%2",_itemName,_addInfo];
				};
				if(_type == "coins") exitWith {
					_pic = getText (configFile >> 'CfgWeapons' >> 'EvMoney' >> 'picture');
					_qty = _x select 2;
					_text = format["%1 %2",_qty call BIS_fnc_numberText,_x select 1];
				};
				if(_type == "weapon") exitWith {
					_pic = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'picture');
					_itemName = getText (configFile >> 'CfgWeapons' >> _x select 1 >> 'displayName');
					_qty = _x select 2;
					if(_qty > 1) then {
						_addInfo = format["\nx %1",_qty];
					};
					_text = format["%1%2",_itemName,_addInfo];
				};
				if(_type == "magazine") exitWith {
					_pic 		= getText (configFile >> 'CfgMagazines' >> _x select 1 >> 'picture');
					_itemName 	= getText (configFile >> 'CfgMagazines' >> _x select 1 >> 'displayName');
					_qty 		= _x select 2;
					_className	= _x select 1;

					call {
						if(_className == "ItemBriefcase_Base") exitWith { _itemName = "EpochPack Premium"; };
						if(_className == "ItemSilvercase_Base") exitWith { _itemName = "EpochPack Silver"; };
					};

					if(_qty > 1) then {
						_addInfo = format["\nx %1",_qty];
					};
					_text = format["%1%2",_itemName,_addInfo];
				};
				if(_type == "script") exitWith {
					_pic = "";
					_text = _x select 1;
				};
			};

			ctrlSetText[81201 + _forEachIndex,_pic];
			ctrlSetText[81301 + _forEachIndex,_text];

			_display	= findDisplay 81000;
			_frame_ctrl = _display displayCtrl 81101 + _forEachIndex;
			_text_ctrl	= _display displayCtrl 81301 + _forEachIndex;
			_rarity		= _x select 3;

			call {
				if(_rarity == 1) exitWith {
					_frame_ctrl ctrlSetTextColor [0.6,0.6,0.6,0.5];
					_text_ctrl ctrlSetTextColor [0.6,0.6,0.6,0.5];
				};
				if(_rarity == 2) exitWith {
					_frame_ctrl ctrlSetTextColor [1,1,1,0.5];
					_text_ctrl ctrlSetTextColor [1,1,1,0.5];
				};
				if(_rarity == 3) exitWith {
					_frame_ctrl ctrlSetTextColor [0.93,0.79,0,0.9];
					_text_ctrl ctrlSetTextColor [0.93,0.79,0,0.9];
				};
				if(_rarity == 4) exitWith {
					_frame_ctrl ctrlSetTextColor [0.83,0.29,0.41,1];
					_text_ctrl ctrlSetTextColor [0.83,0.29,0.41,1];
				};
			};
		} forEach mbc_rewardlist_temp;
	};

	Sleep 0.2;
	_dialog = createdialog "MBC_DIALOG";
	call UpdateMBCDialog;
	waitUntil { !dialog };

	cutText["Claiming reward..","PLAIN DOWN"];

	Sleep 0.2;

	_cashToAdd = 0;

	{
		private["_type","_magazines","_magazineClass","_currentMoney"];

		_type = _x select 0;

		call {
			if(_type == "group_wep") exitWith {
				_spawnCrate addWeaponCargoGlobal [_x select 1,1];
				_magazines = getArray (configFile >> "CfgWeapons" >> _x select 1 >> "magazines");
				if(count _magazines > 0) then
				{
					_magazineClass = _magazines select 0;
					_spawnCrate addMagazineCargoGlobal [_magazineClass,_x select 2];
				}
			};
			if(_type == "group_tool") 	exitWith { _spawnCrate addWeaponCargoGlobal [_x select 1,1]; };
			if(_type == "group_mag") 	exitWith { _spawnCrate addMagazineCargoGlobal [_x select 1,_x select 2];};
			if(_type == "coins") 		exitWith { _cashToAdd = _cashToAdd + (_x select 2); };
			if(_type == "weapon") 		exitWith { _spawnCrate addWeaponCargoGlobal [_x select 1,_x select 2]; };
			if(_type == "magazine") 	exitWith { _spawnCrate addMagazineCargoGlobal [_x select 1,_x select 2]; };
			if(_type == "script") exitWith { [_x select 2] execVM _x select 1; };
		};
	} count mbc_rewardlist_temp;

	if(_cashToAdd > 0) then {
		_currentMoney = player getVariable["cashMoney",0];
		player setVariable["cashMoney",_currentMoney + _cashToAdd,true];
	};

	PVDZE_plr_Save = [player,(magazines player),true,true] ;
	publicVariableServer "PVDZE_plr_Save";

	PVDZE_log = [format["EPOCHPACK: Player %1 (%2) - Reward: %3",name player,getPlayerUID player,mbc_rewardlist_temp]];
	publicVariableServer "PVDZE_log";

	cutText[format["Reward claimed - the contents have been put inside the box which will auto-remove in %1 minutes",(MBT_CRATEDELAY/60)],"PLAIN DOWN"];

	sleep MBT_CRATEDELAY;
	deletevehicle _spawnCrate;

};