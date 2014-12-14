fnc_removeCoins = {

	private["_player","_player_money","_cost","_return"];

	_player			= _this select 0;
	_cost			= _this select 1;
	_player_money	= _player getVariable["cashMoney",0];
	_return			= false;

	if(_player_money >= _cost) then {
		_player setVariable["cashMoney",(_player_money - _cost),true];
		PVDZE_plr_Save = [_player,(magazines player),true,true];
		publicVariableServer "PVDZE_plr_Save";
		_return = true;
	} else {
		_return = false;
	};

	_return
};

VaultWithdrawAmount = {

	private["_amount","_vault","_wealth","_money","_vault_id","_new_money","_new_wealth"];

	_amount 	= round(parseNumber(_this select 0));	
	_vault		= targetvault;
	_money		= _vault getVariable["Money",0];
	_vault_id	= parseNumber(_vault getVariable["ObjectID",0]);
	_wealth 	= player getVariable["cashMoney",0];

	if(_vault_id != 0) then {

		if(_amount < 1 || _amount > _money) then { 
			cutText["Not enough money in vault","PLAIN DOWN"]; 
		} else {
			_new_money 		= (_money - _amount);
			_new_wealth	 	= (_wealth + _amount);

			player setVariable["cashMoney",_new_wealth,true];
			_vault setVariable["Money",_new_money,true];

			PVDZE_plr_Save = [player,(magazines player),true,true] ;
			publicVariableServer "PVDZE_plr_Save";
			PVDZE_vault_Save = [_new_money,_vault_id];
			publicVariableServer "PVDZE_vault_Save";

			cutText[format["You have withdrawn %1 %2.",[_amount] call BIS_fnc_numberText,CurrencyName],"PLAIN DOWN"];

		};

	} else {
		diag_log format["Missing vault %1",target_vault];
	};

	target_vault = -1;
};

VaultDepositAmount = {

	private["_amount","_vault","_wealth","_money","_vault_id","_new_wealth","_new_money"];

	_amount 	= round(parseNumber(_this select 0));
	_vault 		= targetvault;

	_money		= _vault getVariable["Money",0];
	_vault_id	= parseNumber(_vault getVariable["ObjectID",0]);
	_wealth 	= player getVariable["cashMoney",0];

	if(_vault_id != 0) then {

		if(_amount < 1 || _amount > _wealth) then { 
			cutText["You cannot deposit more than you have","PLAIN DOWN"]; 
		} else {
			_new_money 		= _money + _amount;
			_new_wealth	 	= _wealth - _amount;

			player setVariable["cashMoney",_new_wealth,true];
			_vault setVariable["Money",_new_money,true];

			PVDZE_plr_Save = [player,(magazines player),true,true] ;
			publicVariableServer "PVDZE_plr_Save";
			PVDZE_vault_Save = [_new_money,_vault_id];
			publicVariableServer "PVDZE_vault_Save";

			cutText[format["You have deposited %1 %2.",[_amount] call BIS_fnc_numberText,CurrencyName],"PLAIN DOWN"];
		};
	} else {
		diag_log format["Missing vault %1",target_vault];
	};

	target_vault = -1;
};

GivePlayerAmount = {

	private["_amount","_target","_wealth","_twealth"];

	_amount 	= round(parseNumber(_this select 0));
	_target 	= cursorTarget;
	_wealth 	= player getVariable["cashMoney",0];
	_twealth	= _target getVariable["cashMoney",0];

	if(_amount < 1 or _amount > _wealth) exitWith {
		cutText["You can not give more than you currently have","PLAIN DOWN"];
	};

	player setVariable["cashMoney",_wealth - _amount,true];
	_target setVariable["cashMoney",_twealth + _amount,true];

	PVDZE_plr_Save = [player,(magazines player),true,true] ;
	publicVariableServer "PVDZE_plr_Save";

	PVDZE_plr_Save = [_target,(magazines _target),true,true] ;
	publicVariableServer "PVDZE_plr_Save";

	PVDZE_log = [format["MONEY TRANSACTION: %1 (%4) gave %2 (%5) %3 coins",name player,name _target,_amount,getPlayerUID player,getPlayerUID _target]];
	publicVariableServer "PVDZE_log";

	cutText[format["You gave %1 %2",_amount,CurrencyName],"PLAIN DOWN"];
};