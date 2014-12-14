private["_vault","_vault_action","_money","_vaultID"];

_vault 			= (_this select 3) select 0;
_vault_action 	= (_this select 3) select 1;

if(typeName _vault == "OBJECT" && !isNull _vault) then {

	_vaultID = _vault getVariable["ObjectID",false];

	if(typeName _vaultID == "STRING") then {
		_vaultID = parseNumber(_vaultID);
	};

	if(typeName _vaultID == "SCALAR" && _vaultID != 0) then {

		_money = _vault getVariable["Money",true];

		if(typeName _money == "BOOL") then {
			PVDZE_vault_Get = [_vault,player];
			publicVariableServer "PVDZE_vault_Get";

			waitUntil {!isNil "vaultResult"};

			vaultResult = nil;

			_money = _vault getVariable["Money",0];
		};

		_money = _money call BIS_fnc_numberText;

		createDialog 'RscDisplayPassword';

		targetvault = _vault;

		if(_vault_action == 1) then {
			ctrlSetText[1001,format["Get Money - (%1)",_money]];
			ctrlSetText[1002,format['Max (%1)',_money]];
			ctrlSetText[101,''];
			buttonSetaction[1,'[(ctrlText 101)] spawn VaultWithdrawAmount'];
		} else {
			ctrlSetText[1001,format["Deposit Money - (%1)",_money]];
			ctrlSetText[1002,format['Max (%1)',player getVariable["cashMoney",0]]];
			ctrlSetText[101,''];
			buttonSetaction[1,'[(ctrlText 101)] spawn VaultDepositAmount'];
		};

	} else {
		cutText[format["Cannot find ID (%1) of safe/lockbox (%2), please try again in a few seconds",typeName _vaultID,_vault],"PLAIN DOWN"];
	};

} else {
	cutText["Something went wrong trying, please try again in a few seconds.","PLAIN DOWN"];
};