vnetConfig = {
    addressSpace = [ "10.102.0.0/16" ]
    subnets = [
        {
            name = "inside"
            cidr = "10.102.0.0/24"
        },
        {
            name = "outside"
            cidr = "10.102.1.0/24"
        },
        {
            name = "management"
            cidr = "10.102.254.0/24"
        }
    ]
}
gatewaySubnet = "10.102.255.0/24"