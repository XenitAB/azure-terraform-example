environmentShort = "prod"
vnetConfig = {
  addressSpace = ["10.102.0.0/16"]
  subnets = [
    {
      name      = "aks"
      cidr      = "10.102.0.0/24"
      aksSubnet = true
    },
    {
      name      = "servers"
      cidr      = "10.102.1.0/16"
      aksSubnet = false
    }
  ]
}
