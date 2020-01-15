# Add data source for the Azure AD Group for resource group owner
data "azuread_group" "aadGroupRgOwner" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  name = "azr-rg-${var.subscriptionCommonName}-${var.environmentShort}-${each.key}-owner"
}

# Add data source for the Azure AD Group for resource group contributor
data "azuread_group" "aadGroupRgContributor" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  name = "azr-rg-${var.subscriptionCommonName}-${var.environmentShort}-${each.key}-contributor"
}

# Add data source for the Azure AD Group for resource group reader
data "azuread_group" "aadGroupRgReader" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  name = "azr-rg-${var.subscriptionCommonName}-${var.environmentShort}-${each.key}-reader"
}

resource "azuread_group_member" "aadGroupMemberRgOwner" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  group_object_id  = azuread_group.aadGroupEdit[each.key].id
  member_object_id = data.azuread_group.aadGroupRgOwner[each.key].id
}

resource "azuread_group_member" "aadGroupMemberRgContributor" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  group_object_id  = azuread_group.aadGroupEdit[each.key].id
  member_object_id = data.azuread_group.aadGroupRgContributor[each.key].id
}

resource "azuread_group_member" "aadGroupMemberRgReader" {
  for_each = {
    for ns in var.k8sNamespaces :
    ns.name => ns
    if ns.delegateRg == true
  }
  group_object_id  = azuread_group.aadGroupView[each.key].id
  member_object_id = data.azuread_group.aadGroupRgReader[each.key].id
}
