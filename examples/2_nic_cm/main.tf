
# Deploy BIGIQ Module
module "bigiq" {
  source = "github.com/vinnie357/terraform-azure-bigiq?ref=master"
  # setup
  prefix = var.projectPrefix
  buildSuffix = "-${random_pet.buildSuffix.id}"
  subscriptionID = var.subscriptionID
  resourceGroup = azurerm_resource_group.main.id
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
  bigIqLicenseKey1 = var.bigIqLicenseKey1
  sshPublicKey = var.sshPublicKey
  #networks
  subnets = var.subnets
  cidr = var.cidr
  bigiqMgmtIp = var.bigiqMgmtIp
  bigiqDiscoveryIp = var.bigiqDiscoveryIp
}