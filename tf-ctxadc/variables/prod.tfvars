environmentShort = "prod"
azureLbConfig = {
  pipCount = 3
  insideIpAddresses = [
    "10.102.0.104",
    "10.102.0.105",
    "10.102.0.106"
  ]
}
ipConfiguration = [
  {
    management = [
      "10.102.254.100",
      "10.102.254.102"
    ]
    inside = [
      "10.102.0.100",
      "10.102.0.102"
    ]
    outside = [
      "10.102.1.100",
      "10.102.1.102"
    ]
  },
  {
    management = [
      "10.102.254.101",
      "10.102.254.103"
    ]
    inside = [
      "10.102.0.101",
      "10.102.0.103"
    ]
    outside = [
      "10.102.1.101",
      "10.102.1.103"
    ]
  }
]
