resource "azurerm_network_interface" "nicInside" {
  count                = var.vmConfig.count
  name                 = "nic-${local.vmBaseName}-${format("%02s", count.index + 1)}-inside"
  location             = data.azurerm_resource_group.rg.location
  resource_group_name  = data.azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  dynamic "ip_configuration" {
    for_each = {
      for ip in var.ipConfiguration[count.index].inside : ip => ip
    }
    content {
      name                          = "ipconfig-${ip_configuration.value}"
      subnet_id                     = data.azurerm_subnet.insideSubnet.id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value
    }
  }
}

resource "azurerm_network_interface" "nicOutside" {
  count                = var.vmConfig.count
  name                 = "nic-${local.vmBaseName}-${format("%02s", count.index + 1)}-outside"
  location             = data.azurerm_resource_group.rg.location
  resource_group_name  = data.azurerm_resource_group.rg.name
  enable_ip_forwarding = true

  dynamic "ip_configuration" {
    for_each = {
      for ip in var.ipConfiguration[count.index].outside : ip => ip
    }
    content {
      name                          = "ipconfig-${ip_configuration.value}"
      subnet_id                     = data.azurerm_subnet.outsideSubnet.id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value
    }
  }
}

resource "azurerm_network_interface" "nicManagement" {
  count               = var.vmConfig.count
  name                = "nic-${local.vmBaseName}-${format("%02s", count.index + 1)}-management"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name

  dynamic "ip_configuration" {
    for_each = {
      for ip in var.ipConfiguration[count.index].management : ip => ip
    }
    content {
      name                          = "ipconfig-${ip_configuration.value}"
      subnet_id                     = data.azurerm_subnet.managementSubnet.id
      private_ip_address_allocation = "Static"
      private_ip_address            = ip_configuration.value
    }
  }
}
