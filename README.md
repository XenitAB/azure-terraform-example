# azure-terraform-example
Terraform example to have a short developer loop and pipeline in Azure DevOps (CI/CD).

# Before using
## Create an Azure connection
Go to (in Azure DevOps) Project Settings > Service connections > New service connection > Azure Resource Manager > Name will be used as `azureSubscription` in the pipeline yaml (`.ci/pipeline-tf-infra-core` as an example.)

## Modify .ci/Invoke-PipelineTask.ps1 to reflect your environment:
```powershell
    [string]$tfBackendKey = "$($environmentShort).terraform.tfstate",
    [string]$tfBackendResourceGroupLocation = "West Europe",
    [string]$tfBackendResourceGroupLocationShort = "we",
    [string]$tfBackendResourceGroup = "rg-$($environmentShort)-$($tfBackendResourceGroupLocationShort)-tfstate",
    [string]$tfBackendStorageAccountName = "strg$($environmentShort)$($tfBackendResourceGroupLocationShort)tfstate",
    [string]$tfBackendStorageAccountKind = "StorageV2",
    [string]$tfBackendContainerName = "tfstate"
```

# Setting up
## Run Terraform
### Manual (powershell)
```
az login

cd tf-core-infra

terraform init
terraform plan
terraform validate
terraform apply
```

### Manual (powershell script)
```
az login

pwsh .ci/Invoke-PipelineTask.ps1 -tfFolderName tf-core-infra -build
pwsh .ci/Invoke-PipelineTask.ps1 -tfFolderName tf-core-infra -deploy
```

### Azure DevOps
The recommended way of running it, since all the configuration required is included. Add the service connection and modify the variable variables to reflect your environment, see `.ci/pipeline-tf-infra-core.yml` for an example.