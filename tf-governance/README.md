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

# Import tfstate to different environments

```bash
rm -rf tf-governance/.terraform
ENVIRONMENT=dev
az account set --subscription SubscriptionName-$ENVIRONMENT
AZ_SUBSCRIPTION_ID=$(az account show --out tsv --query 'id')
pwsh .ci/Invoke-PipelineTask.ps1 -tfFolderName tf-governance -build -environmentShort $ENVIRONMENT
cd tf-governance
terraform import -var-file=variables/common.tfvars -var-file=variables/$ENVIRONMENT.tfvars 'azurerm_resource_group.rg["tfstate"]' /subscriptions/$AZ_SUBSCRIPTION_ID/resourceGroups/rg-$ENVIRONMENT-we-tfstate
cd ..
```