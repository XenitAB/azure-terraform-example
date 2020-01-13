environmentShort = "dev"
azureLbConfig = {
  pipCount = 3
  insideIpAddresses = [
    "10.100.0.104",
    "10.100.0.105",
    "10.100.0.106"
  ]
}
ipConfiguration = [
  {
    management = [
      "10.100.254.100",
      "10.100.254.102"
    ]
    inside = [
      "10.100.0.100",
      "10.100.0.102"
    ]
    outside = [
      "10.100.1.100",
      "10.100.1.102"
    ]
  },
  {
    management = [
      "10.100.254.101",
      "10.100.254.103"
    ]
    inside = [
      "10.100.0.101",
      "10.100.0.103"
    ]
    outside = [
      "10.100.1.101",
      "10.100.1.103"
    ]
  }
]
