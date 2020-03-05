location       = "West Europe"
locationShort  = "we"
commonName     = "tf"
coreCommonName = "tflab"

kvDefaultPermissions = {
  key_permissions = [
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey"
  ]
  secret_permissions = [
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set"
  ]
}

rgConfig = [
  {
    commonName  = "tfstate",
    delegateAks = false,
    delegateKv  = false,
    delegateSe  = false,
    tags = {
      "description" = "State for terraform"
    }
  },
  {
    commonName  = "tflab",
    delegateAks = false,
    delegateKv  = false,
    delegateSe  = false,
    tags = {
      "description" = "Core infrastructure"
    }
  },
  {
    commonName  = "asc",
    delegateAks = false,
    delegateKv  = false,
    delegateSe  = false,
    tags = {
      "techContact" = "Xenit AB",
      "description" = "Velocitas Azure Security Center",
      "RF_ID"       = "Affärsstöd"
    }
  },
  {
    commonName  = "aks",
    delegateAks = false,
    delegateKv  = false,
    delegateSe  = false,
    tags = {
      "description" = "Azure Kubernetes Service (AKS)"
    }
  },
  {
    commonName  = "team1",
    delegateAks = true,
    delegateKv  = false,
    delegateSe  = true,
    tags = {
      "description" = "Team1 resource group"
    }
  },
  {
    commonName  = "team2",
    delegateAks = true,
    delegateKv  = true,
    delegateSe  = true,
    tags = {
      "description" = "Team2 resource group"
    }
  },
  {
    commonName  = "ctxadm",
    delegateAks = false,
    delegateKv  = false,
    delegateSe  = false,
    tags = {
      "description" = "Citrix Application Delivery Management"
    }
  }
]
