# Terraform Core Infrastructure for Azure

This will setup the following resources:

* Azure KeyVault for storing secrets for the environment
* Virtual Network
* Subnets
* Network Security Groups

## Before running

### Variables

You need to update the variables before running the playbook in `variables/common.tfvars`.

### Azure KeyVault

You need to run `tf-governance` before you run this. You will have to comment (`#`) out the KeyVault specific configuration.
