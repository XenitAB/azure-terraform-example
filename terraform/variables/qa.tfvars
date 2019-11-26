location = "West Europe"
locationShort = "we"
environmentShort = "qa"
vnetConfig = {
    addressSpace = [ "10.101.0.0/16" ]
    subnets = [
        {
            name = "inside"
            cidr = "10.101.0.0/24"
        },
        {
            name = "outside"
            cidr = "10.101.1.0/24"
        },
        {
            name = "management"
            cidr = "10.101.254.0/24"
        }
    ]
}
gatewaySubnet = "10.101.255.0/24"