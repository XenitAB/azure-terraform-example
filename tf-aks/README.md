# AKS Readme

## First run

It will fail the first time it runs. Let it fail and then go through the below steps and then run it again.

## Manual configuration

### Azure AD Applications

#### Server

##### Server admin consent

Go to your Azure AD Directory (after terraform has been applied) and then App Registrations > All Applications > `app-${var.environmentShort}-${var.commonName}-server` > API Permissions and click `Grant admin consent`. Verify that the status is changed on the permissions.

#### Client

##### Client admin consent

Go to your Azure AD Directory (after terraform has been applied) and then App Registrations > All Applications > `app-${var.environmentShort}-${var.commonName}-client` > API Permissions and click `Grant admin consent`. Verify that the status is changed on the permissions.
