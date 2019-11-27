vnetConfig = {
    addressSpace = [ "10.100.0.0/16" ]
    subnets = [
        {
            name = "inside"
            cidr = "10.100.0.0/24"
        },
        {
            name = "outside"
            cidr = "10.100.1.0/24"
        },
        {
            name = "management"
            cidr = "10.100.254.0/24"
        }
    ]
}
gatewaySubnet = "10.100.255.0/24"