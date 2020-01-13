environmentShort = "qa"
azureLbConfig = {
  pipCount = 3
  insideIpAddresses = [
    "10.101.0.104",
    "10.101.0.105",
    "10.101.0.106"
  ]
}
ipConfiguration = [
  {
    management = [
      "10.101.254.100",
      "10.101.254.102"
    ]
    inside = [
      "10.101.0.100"
    ]
    outside = [
      "10.101.1.100"
    ]
  },
  {
    management = [
      "10.101.254.101",
      "10.101.254.103"
    ]
    inside = [
      "10.101.0.101"
    ]
    outside = [
      "10.101.1.101"
    ]
  }
]
