# attach interfaces
# Create the first network interface card for Management
resource "azurerm_network_interface" "bigiq-mgmt-nic" {
  name                      = "${var.prefix}bigiq-mgmt-nic${var.buildSuffix}"
  location                  = var.resourceGroup.location
  resource_group_name       = var.resourceGroup.name
  network_security_group_id = var.networkSecurityGroup.id

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnetMgmt.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.bigiqPrivateMgmtIp
    public_ip_address_id          = azurerm_public_ip.bigiqpip.id
  }

  tags = {
    Name        = "${var.environment}-bigiq-mgmt-int"
    environment = var.environment
    owner       = var.owner
    group       = var.group
    costcenter  = var.costcenter
    application = var.application
  }
}
# Create the second network interface card for discovery
resource "azurerm_network_interface" "bigiq-discovery-nic" {
  name                          = "${var.prefix}bigiq-discovery-nic${var.buildSuffix}"
  location                      = var.resourceGroup.location
  resource_group_name           = var.resourceGroup.name
  network_security_group_id     = var.networkSecurityGroup.id
  enable_accelerated_networking = true

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnetDiscovery.id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.bigiqPrivateDiscoveryIp
    primary                       = true
  }

  tags = {
    Name                      = "${var.environment}-bigiq-discovery-int"
    environment               = var.environment
    owner                     = var.owner
    group                     = var.group
    costcenter                = var.costcenter
    application               = var.application
    f5_cloud_failover_label   = "bigiq"
    f5_cloud_failover_nic_map = "discovery"
  }
}
# Create a Public IP for the Virtual Machines
resource "azurerm_public_ip" "bigiqpip" {
  name                = "${var.prefix}vm01-mgmt-pip01${var.buildSuffix}"
  location            = var.resourceGroup.location
  resource_group_name = var.resourceGroup.name
  allocation_method   = "Dynamic"

  tags = {
    Name = "${var.prefix}-f5vm-public-ip"
  }
}
# Setup Onboarding scripts
data "template_file" "vm_onboard" {
  template = "${file("${path.module}/onboard.sh.tmpl")}"

  vars = {
    adminName              = var.adminName
    adminPassword          = var.adminPassword
    onboardLog             = var.onboardLog
    bigIqLicenseKey        = var.bigIqLicenseKey
    ntpServers             = var.ntpServers
    timeZone               = var.timeZone
    licensePoolKeys        = var.licensePoolKeys
    regPoolKeys            = var.regPoolKeys
    masterKey              = var.masterKey
    f5CloudLibsTag         = var.f5CloudLibsTag
    f5CloudLibsAzureTag    = var.f5CloudLibsAzureTag
    allowUsageAnalytics    = var.allowUsageAnalytics
    location               = var.location
    deploymentId           = var.deploymentId
    hostName               = "${var.hostName}.${var.dnsSearchDomains}"
    discoveryAddressSelfip = "${var.bigiqPrivateDiscoveryIp}/${var.bigiqPrivateDiscoveryIpCidr}"
    discoveryAddress       = var.bigiqPrivateDiscoveryIp
    dnsSearchDomains       = var.dnsSearchDomains
    dnsServers             = var.dnsServers
  }
}

# create bigiq
resource "azurerm_virtual_machine" "bigiq" {
  name                         = "${var.prefix}bigiq${var.buildSuffix}"
  location                     = var.resourceGroup.location
  resource_group_name          = var.resourceGroup.name
  primary_network_interface_id = azurerm_network_interface.bigiq-mgmt-nic.id
  network_interface_ids        = [azurerm_network_interface.bigiq-mgmt-nic.id, azurerm_network_interface.bigiq-discovery-nic.id]
  vm_size                      = var.instanceType

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "f5-networks"
    offer     = var.product
    sku       = var.imageName
    version   = var.bigiqVersion
  }

  storage_os_disk {
    name              = "${var.prefix}bigiq-osdisk${var.buildSuffix}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.diskType
  }

  os_profile {
    computer_name  = "${var.prefix}bigiq"
    admin_username = var.adminName
    admin_password = var.adminPassword
    custom_data    = data.template_file.vm_onboard.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
    ssh_keys {
      #NOTE: Due to a limitation in the Azure VM Agent the only allowed path is /home/{username}/.ssh/authorized_keys.
      path     = "/home/${var.adminName}/.ssh/authorized_keys"
      key_data = var.sshPublicKey
    }
  }

  plan {
    name      = var.imageName
    publisher = "f5-networks"
    product   = var.product
  }

  tags = {
    Name        = "${var.environment}-bigiq"
    environment = var.environment
    owner       = var.owner
    group       = var.group
    costcenter  = var.costcenter
    application = var.application
  }

}

# Run Startup Script
resource "azurerm_virtual_machine_extension" "bigiq-run-startup-cmd" {
  name                 = "${var.environment}bigiq-run-startup-cmd${var.buildSuffix}"
  depends_on           = [azurerm_virtual_machine.bigiq]
  location             = var.region
  resource_group_name  = var.resourceGroup.name
  virtual_machine_name = azurerm_virtual_machine.bigiq.name
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
    {
        "commandToExecute": "mkdir -p /var/log/cloud/azure;mkdir -p /config/cloud;cat /var/lib/waagent/CustomData > /config/cloud/init.sh; chmod +x /config/cloud/init.sh;bash /config/cloud/init.sh  &>> /var/log/cloud/azure/install.log"
    }
  SETTINGS

  tags = {
    Name        = "${var.environment}-bigiq-startup-cmd"
    environment = var.environment
    owner       = var.owner
    group       = var.group
    costcenter  = var.costcenter
    application = var.application
  }
}

data "azurerm_public_ip" "managementPublicAddress" {
  name                = azurerm_public_ip.bigiqpip.name
  resource_group_name = var.resourceGroup.name
  depends_on          = [azurerm_virtual_machine_extension.bigiq-run-startup-cmd]
}
