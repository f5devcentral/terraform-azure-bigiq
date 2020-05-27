
# Deploy BIGIQ Module
module "bigiq" {
  source = "github.com/vinnie357/terraform-azure-bigiq?ref=master"
  # setup
  prefix = var.projectPrefix
  buildSuffix = "-${random_pet.buildSuffix.id}"
  resourceGroup = azurerm_resource_group.main
  instanceType = var.instanceType
  # bigiq
  imageName = var.imageName
  bigipVersion = var.bigiqVersion
  hostName = var.host1Name
  dnsServers = var.dnsServers
  ntpServers = var.ntpServers
  dnsSearchDomains = var.dnsSearchDomains
  masterKey = var.masterKey
  timeZone = var.timeZone
  # admin
  adminSourceRange = var.adminSourceRange
  adminPassword      = var.adminAccountPassword
  adminName        = var.adminAccountName
  bigIqLicenseKey = var.bigIqLicenseKey
  sshPublicKey = var.sshPublicKey
  #networks
  subnetMgmt = azurerm_subnet.mgmt
  subnetDiscovery = azurerm_subnet.discovery
  bigiqPrivateDiscoveryIpCidr = var.bigiqPrivateDiscoveryIpCidr
  cidr = var.cidr
  bigiqPrivateMgmtIp = var.bigiqPrivateMgmtIp
  bigiqPrivateDiscoveryIp = var.bigiqPrivateDiscoveryIp
  networkSecurityGroup = azurerm_network_security_group.main
}