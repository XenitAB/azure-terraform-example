location        = "West Europe"
locationShort   = "we"
commonName      = "tflab"
groupCommonName = "tf"
hubVnetId       = "/subscriptions/<subscription_id>/resourceGroups/<rg_name>/providers/Microsoft.Network/virtualNetworks/<vnet_name>"

vpnConfiguration = [
  {
    name            = "peer"
    remoteGatewayIp = "1.2.3.4"
    remoteSubnets = [
      "192.168.0.0/24"
    ]
  }
]
