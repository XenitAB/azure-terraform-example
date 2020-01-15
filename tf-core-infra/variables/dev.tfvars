environmentShort = "dev"
vnetConfig = {
  addressSpace = ["10.100.0.0/16"]
  subnets = [
    {
      name      = "aks"
      cidr      = "10.100.0.0/24"
      aksSubnet = true
    },
    {
      name      = "servers"
      cidr      = "10.100.1.0/24"
      aksSubnet = false
    }
  ]
}
