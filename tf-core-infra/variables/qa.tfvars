environmentShort = "qa"
vnetConfig = {
  addressSpace = ["10.101.0.0/16"]
  subnets = [
    {
      name      = "aks"
      cidr      = "10.101.0.0/24"
      aksSubnet = true
    },
    {
      name      = "servers"
      cidr      = "10.101.1.0/24"
      aksSubnet = false
    }
  ]
}
