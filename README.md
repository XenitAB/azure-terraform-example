# azure-terraform-hubspoke
Terraform example for setting up hub-and-spoke in Azure using Azure DevOps (CI/CD)

# Before using
## Create an Azure connection
Go to (in Azure DevOps) Project Settings > Service connections > New service connection > Azure Resource Manager > Name will be used as `azureSubscription` in the azure-pipelines.yml variables

## Add the resource group and storage account/container used by `main.tf`:
```
terraform {
  backend "azurerm" {
    resource_group_name  = "<resourceGroupName>"
    storage_account_name = "<storageAccountName>"
    container_name       = "<containerName>"
  }
}
```

# Setting up
## Run Terraform
### Manual (powershell)
```
az login

cd terraform

terraform init
terraform plan
terraform validate
terraform apply
```

### Manual (powershell script)
```
az login

pwsh .ci/Invoke-PipelineTask.ps1 -build
pwsh .ci/Invoke-PipelineTask.ps1 -deploy
```

### Azure DevOps
The recommended way of running it, since all the configuration required is included. Add the service connection and modify the variable `azureSubscription` to use azure-pipelines.yml.