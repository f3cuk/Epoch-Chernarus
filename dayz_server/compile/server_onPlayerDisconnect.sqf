private["_invehicle","_isplayernearby","_playerObj","_id","_playerUID","_playerName","_characterID","_timeout","_message","_magazines","_playerPos","_i","_pos","_backpack","_weapons","_weapons_backpack","_current_magazine","_magazines_backpack","_money","_loot_box","_removebackpack"];

_playerUID 	= _this select 0;
_playerName = _this select 1;
_playerObj 	= nil;
_playerPos 	= [];
_removebackpack = false;

{
	if((getPlayerUID _x) == _playerUID) exitWith { _playerObj = _x; };
} count playableUnits;

if(isNil "_playerObj") then {
	diag_log format["nil player object attempting PV,:%1",_this];

	_playerObj = call compile format["PVDZE_player%1",_playerUID];
};

if(isNil "_playerObj") exitWith {
	diag_log format["%1: nil player object,_this:%2",__FILE__,_this];
};

diag_log format["get: %1 (%2),sent: %3 (%4)",typeName (getPlayerUID _playerObj),getPlayerUID _playerObj,typeName _playerUID,_playerUID];

if(!isNull _playerObj) then {

	_playerPos 		= [_playerObj] call FNC_GetPos;
	_characterID 	= _playerObj getVariable["CharacterID","0"];
	_timeout 		= _playerObj getVariable["combattimeout",0];

	_invehicle = false;

	if(vehicle _playerObj != _playerObj) then {
		_playerObj action["eject",vehicle _playerObj];
		_invehicle = true;
		diag_log format["LOGOUT IN VEHICLE: %1 at location %2",_playerName,([_playerObj] call FNC_GetPos)];
	};

	if((_timeout - time) > 0) then {

		_playerObj setVariable["NORRN_unconscious",true,true];
		_playerObj setVariable["unconsciousTime",60,true];

		_pos 				= [_playerObj] call FNC_GetPos;
		_backpack			= unitBackpack _playerObj;
		_weapons			= weapons _playerObj;
		_weapons_backpack 	= getWeaponCargo _backpack;
		_magazines			= magazines _playerObj;
		_current_magazine	= currentMagazine _playerObj;
		_magazines_backpack = getMagazineCargo _backpack;
		_money 				= _playerObj getVariable["cashMoney",0];
		_loot_box 			= createVehicle["USBasicAmmunitionBox",_pos,[],0,"CAN_COLLIDE"];

		clearMagazineCargoGlobal _loot_box;
		clearWeaponCargoGlobal _loot_box;

		_loot_box setVariable["cashMoney",_money,true];

		{
			_loot_box addWeaponCargoGlobal [_x,1];
		} count (_weapons);

		_magazines set[(count _magazines),_current_magazine];

		{
			_loot_box addMagazineCargoGlobal [_x,1];
		} count (_magazines);

		if(typename _weapons_backpack == "ARRAY") then {

			_i = 0;

			{
				_loot_box addWeaponCargoGlobal [_x,((_weapons_backpack select 1) select _i)];
				_i = _i + 1;
			} count (_weapons_backpack select 0);

		};

		if(typename _magazines_backpack == "ARRAY") then {

			_i = 0;

			{
				_loot_box addMagazineCargoGlobal [_x,((_magazines_backpack select 1) select _i)];
				_i = _i + 1;
			} count (_magazines_backpack select 0);

		};

		_loot_box addBackpackCargoGlobal[(typeOf _backpack),1];
		_loot_box setVariable["permaLoot",true];

		diag_log format["COMBAT LOGGED: %1 (%2) at location %3 - DEBUG: Weapons: (%4 - %5) / Magazines: (%6 - %7) / Backpack: (%8) / Money: (%9)",_playerName,_timeout,([_playerObj] call FNC_GetPos),_weapons,_weapons_backpack,_magazines,_magazines_backpack,_backpack,_money];

		_message = format["PLAYER COMBAT LOGGED: %1",_playerName];

		[nil,nil,rTitleText,_message,"PLAIN"] call RE;

		_removebackpack = true;

		{
			_playerObj removeMagazine _x;
		} count magazines _playerObj;

		{
			_playerObj removeWeapon _x;
		} count _weapons;

		_playerObj setVariable["cashMoney",0];
	};

	diag_log format["DISCONNECT: %1 (%2) Object: %3,_characterID: %4 at loc %5",_playerName,_playerUID,_playerObj,_characterID,([_playerObj] call FNC_GetPos)];

	_id = [_playerUID,_characterID,2] spawn dayz_recordLogin;

	if(alive _playerObj) then {
		_isplayernearby = (DZE_BackpackGuard && !_invehicle && ({(isPlayer _x) && (alive _x)} count (_playerPos nearEntities ["AllVehicles",5]) > 1));
		_magazines = [(magazines _playerObj),20] call array_reduceSize;

		[_playerObj,_magazines,true,true,_isplayernearby,_removebackpack] call server_playerSync;
		_playerObj call dayz_removePlayerOnDisconnect;
	} else {
		{ 
			[_x,"gear"] call server_updateObject;
		} count (nearestObjects[_playerPos,dayz_updateObjects,10]);
	};
};