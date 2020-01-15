# Terraform Governance for Azure

This will setup the following resources:

* Resource groups
* Azure AD groups
* Service principals
* Delegate Azure AD groups and service principals to resource groups
* Store service principal passwords in Azure KeyVault
* Create Azure AD groups for Azure Container Registry delegation

## Before running

### Variables

You need to update the variables before running the playbook in `variables/common.tfvars`.

### Azure KeyVault

The first time you run this, you will need to comment out (`#`) the KeyVault specifics until it is created with `tf-core-infra`.

The following addresses should be commented at the first run:

* `azurerm_key_vault_secret.aadSpKvSecret` in `spSubReader.tf`
* `azurerm_key_vault_secret.aadSubReaderSpKvSecret` in `sp.tf`
* `data.azurerm_key_vault.coreKv` in `kv.tf`
