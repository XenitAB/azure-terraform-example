resource "azurerm_log_analytics_workspace" "laWorkspace" {
  name                = "la-${var.environmentShort}-${var.locationShort}-${var.commonName}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  sku                 = "PerGB2018"
}

data "local_file" "ascArmTemplate" {
  filename = "${path.module}/arm/asc.json"
}

data "local_file" "ascArmTemplateParameters" {
  filename = "${path.module}/arm/asc.parameters.json"
}

resource "null_resource" "azDeploymentAsc" {
  provisioner "local-exec" {
    command = "az deployment create --name 'asc-deployment-${formatdate("YYYYMMDDhhmmss", timestamp())}'  --location ${data.azurerm_resource_group.rg.location} --template-file arm/asc.json --parameters arm/asc.parameters.json --parameters workspaceId=${azurerm_log_analytics_workspace.laWorkspace.id}"
  }

  triggers = {
    hash = sha1("${data.local_file.ascArmTemplate.content_base64}${data.local_file.ascArmTemplateParameters.content_base64}${azurerm_log_analytics_workspace.laWorkspace.id}")
  }
}
