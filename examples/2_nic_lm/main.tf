
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
  upassword      = var.adminAccountPassword
  uname         = var.adminAccountName
  bigIqLicenseKey = var.bigIqLicenseKey
  sshPublicKey = var.sshPublicKey
  #networks
  subnetMgmt = var.subnetMgmt
  subnetDiscovery = var.subnetDiscovery
  bigiqPrivateDiscoveryIpCidr = var.bigiqPrivateDiscoveryIpCidr
  cidr = var.cidr
  bigiqPrivateMgmtIp = var.bigiqPrivateMgmtIp
  bigiqPrivateDiscoveryIp = var.bigiqPrivateDiscoveryIp
  networkSecurityGroup = var.networkSecurityGroup
}