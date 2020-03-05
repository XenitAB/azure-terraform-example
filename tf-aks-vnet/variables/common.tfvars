location               = "West Europe"
locationShort          = "we"
commonName             = "aks"
subscriptionCommonName = "tf"
coreCommonName         = "tflab"

k8sNamespaces = [
  {
    name       = "team1"
    delegateRg = true
    labels = {
      "terraform" = "true"
    }
  },
  {
    name       = "team2"
    delegateRg = true
    labels = {
      "terraform" = "true"
    }
  }
]
k8sSaNamespace = "service-accounts"
