target_vault = _this select 3;

if(typeName target_vault == "OBJECT") then {

	PVDZE_vault_Get = [target_vault,player];
	publicVariableServer "PVDZE_vault_Get";

	waitUntil {!isNil "vaultResult"};

	createdialog "VaultDialog";

	target_vault call VaultUpdateAmounts;

	vaultResult = nil;

	waitUntil {!dialog};

};