resource "random_pet" "buildSuffix" {
  keepers = {
    # Generate a new pet name each time we switch to a new AMI id
    #ami_id = "${var.ami_id}"
    prefix = "${var.projectPrefix}"
  }
  #length = ""
  #prefix = "${var.projectPrefix}"
  separator = "-"
}

# Deploy BIGIQ Module
module "bigiq" {
  source = "github.com/vinnie357/terraform-azure-bigiq?ref=master"
  # setup
  prefix = "${var.projectPrefix}"
  buildSuffix = "-${random_pet.buildSuffix.id}"
  subscriptionID = "${var.subscriptionID}"
  resourceGroup = "${azurerm_resource_group.main.id}"
  instanceType =
  # bigiq
  imageName =
  product =
  bigipVersion =
  hostName =
  dnsServers =
  ntpServers =
  dnsSearchDomains =
  masterKey =
  timeZone =
  # admin
  adminSourceRange = "${var.adminSourceRange}"
  upassword      = "${var.adminAccountPassword}"
  uname         = "${var.adminAccountName}"
  bigIqLicenseKey1 = "${var.bigIqLicenseKey1}"
  #networks
  subnets =
  cidr =
  bigiqMgmtIp =
  bigiqExtIp =
}