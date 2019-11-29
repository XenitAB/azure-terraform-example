# azure-terraform-example
Terraform example to have a short developer loop and pipeline in Azure DevOps (CI/CD).

# Purpose
## Why was this created?
We think Infrastructure as Code should be used by everyone while at the same time being as easy and accessible as possible.
This was created to kick-start individuals, teams and organizations and give them an example of how they can work.

## What can I do with this?
As of writing, we have created two terraform setups. One for the core infrastructure (`tf-core-infra`) and one for governance (`tf-governance`) - as well as Azure Pipelines YAMLs for each. There's also a boilerplate (`tf-boilerplate` and `.ci/pipeline-tf-boilerplate.yml`) which hopefully makes it easier for more setups.

### Governance (`tf-governance`)
Will create the following resources:
* Resource Group per common name (`rg.tf`)
* Azure AD groups and association to the Resource Groups (`aadgroup.tf`)
* Service Principals and association to the Resource Groups (`rg.tf`)

### Core infrastructure (`tf-core-infra`)
Will create the following resources (per environment):
* Virtual Network (`vnet.tf`)
* Subnets in the Virtual Network (`subnets.tf`)
* Network Security Groups and attach them to the subnets (`nsg.tf`)
* KeyVault (`keyVault.tf`)

### Additional information?
Take a look in the `variables` folder for more information. The `common.tfvars` is used by all environments.

Fork this repository, try it out with Azure Pipelines and make it yours. If you do something cool, you can always do a pull request back here.

# Before using
## Create an Azure connection
Go to (in Azure DevOps) Project Settings > Service connections > New service connection > Azure Resource Manager > Name will be used as `azureSubscription` in the pipeline yaml (`.ci/pipeline-tf-infra-core` as an example.)

## Create a variable group
Go to (in Azure DevOps) Pipelines > Library and create the variable group `terraform-encryption` with a variable (should be `secret`) named `terraformEncryptionSecret`. Make sure it's not in clear text - it will be used to encrypt and decrypt the terraform plans stored in artifacts.

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

### Configuring Azure AD permissions
If you are trying out `tf-governance` and get permission denied in the pipeline, make sure you add `Directory.ReadWrite.All` and `Application.ReadWrite.All` to your service principal for the `Azure Active Directory Graph` API (it's under the `Supported legacy APIs` section). You also need to grant admin consent to these permissions. The service principal also need the `Owner` role on the subscription it is running. The service principal also needs to be member of the `User administrator` Azure AD Role.

## Boilerplate
If you want to create a new terraform setup, copy the `tf-boilerplate` folder and `.ci/pipeline-tf-boilerplate.yml` (with your new names). Make sure to update the pipeline yaml where it says boilerplate to your new setup.
