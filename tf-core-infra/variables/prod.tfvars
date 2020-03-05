environmentShort = "prod"
vnetConfig = {
  addressSpace = ["10.102.0.0/16"]
  subnets = [
    {
      name = "aks"
      cidr = "10.102.0.0/24"
      service_endpoints = [
        "Microsoft.Storage",
        "Microsoft.Sql"
      ]
      aksSubnet = true
    },
    {
      name              = "servers"
      cidr              = "10.102.1.0/24"
      service_endpoints = []
      aksSubnet         = false
    }
  ]
}
gatewaySubnet = "10.102.255.0/24"
