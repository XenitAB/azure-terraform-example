location       = "West Europe"
locationShort  = "we"
commonName     = "tf"
coreCommonName = "tflab"
rgConfig = [
  {
    commonName  = "tfstate",
    delegateAks = false,
    tags = {
      "description" = "State for terraform"
    }
  },
  {
    commonName  = "tflab",
    delegateAks = false,
    tags = {
      "description" = "Core infrastructure"
    }
  },
  {
    commonName  = "aks",
    delegateAks = false,
    tags = {
      "description" = "Azure Kubernetes Service (AKS)"
    }
  },
  {
    commonName  = "team1",
    delegateAks = true,
    tags = {
      "description" = "Team1 resource group"
    }
  },
  {
    commonName  = "ctxadm",
    delegateAks = false,
    tags = {
      "techContact" = "Xenit AB",
      "description" = "Citrix Application Delivery Management"
    }
  }
]
