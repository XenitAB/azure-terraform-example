# Terraform Azure Kubernetes Service (AKS) with existing virtual network/subnet

This will setup the following resources:

* Azure Kubernetes Service (AKS)
* Azure Container Registry (ACR)
* DNS Zone for external-dns
* Storage account for Velero
* Service principals for AKS and store in KeyVault
* Service principals for external-dns and Velero (backup) and store in KeyVault
* Delegation of AKS service principal to vnet
* Create SSH keys and store in KeyVault
* Delegate AKS access to Azure AD group
* Delegate ACR access to to AKS and Azure AD groups
* Kubernetes cluster roles
* Kubernetes cluster role bindings
* Kubernetes namespaces
* Kubernetes service accounts (since service principals can't use Azure AD authentication to AKS)

## Additional resources

### Kubernetes configuration

[ansible-kubernetes-configuration](https://github.com/XenitAB/ansible-kubernetes-configuration)

### Example deployment to cluster

[hello-k8s](https://github.com/XenitAB/hello-k8s)

## First run

It will fail the first time it runs. Let it fail and then go through the below steps and then run it again.

You or the service principal running this need to have Contributor access to the Subscription (need access to keyvault and vnet created in `tf-core-infra`)

## Manual configuration

### Azure AD Applications

#### Server

##### Server admin consent

Go to your Azure AD Directory (after terraform has been applied) and then App Registrations > All Applications > `app-${var.environmentShort}-${var.commonName}-server` > API Permissions and click `Grant admin consent`. Verify that the status is changed on the permissions.

#### Client

##### Client admin consent

Go to your Azure AD Directory (after terraform has been applied) and then App Registrations > All Applications > `app-${var.environmentShort}-${var.commonName}-client` > API Permissions and click `Grant admin consent`. Verify that the status is changed on the permissions.

## Using with Azure DevOps

Since it's not possible to use Service Principals together with AKS when Azure AD authentication is enabled, we've created service accounts in the namespace `serivce-accounts` (or something else if you've changed the terraform variable `k8sSaNamespace`).

When adding a service connection in Azure DevOps for Kubernetes, choose service account. Export it using (when logged on as admin):

```bash
kubectl -n service-accounts get secret <service account secret> -o yaml
```

The service accounts will also be exported to the Azure KeyVault for easy access. They will be stored in base64 format and can be used as kube config if decoded.

# Remove state if AKS is removed manually

```
terraform state rm azurerm_kubernetes_cluster.aks
terraform state rm kubernetes_cluster_role.crCitrix
terraform state rm kubernetes_cluster_role_binding.k8sCrbClusterAdmin
terraform state rm kubernetes_cluster_role_binding.k8sCrbClusterView
terraform state rm kubernetes_namespace.k8sNs
terraform state rm kubernetes_namespace.k8sSaNs
terraform state rm kubernetes_role_binding.k8sRbView
terraform state rm kubernetes_role_binding.k8sRbEdit
terraform state rm kubernetes_role_binding.k8sRbCitrix
terraform state rm kubernetes_role_binding.k8sRbSaEdit
terraform state rm kubernetes_role_binding.k8sRbSaCitrix
terraform state rm kubernetes_service_account.k8sSa
```
