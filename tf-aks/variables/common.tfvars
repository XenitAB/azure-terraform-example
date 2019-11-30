location      = "West Europe"
locationShort = "we"
commonName    = "aks"
k8sNamespaces = [
  {
    name = "team1"
    labels = {
      "terraform" = "true"
    }
  }
]
k8sSaNamespace = "service-accounts"
