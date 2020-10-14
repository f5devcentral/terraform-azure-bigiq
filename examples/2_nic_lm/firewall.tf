# Create a Network Security Group with some rules
resource "azurerm_network_security_group" "main" {
  name                = "${var.prefix}nsg-${random_pet.buildSuffix.id}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  # https://support.f5.com/csp/article/K15612
  security_rule {
    name                       = "allow_admin_SSH"
    description                = "Allow SSH access"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefixes    = var.adminSourceRange
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_admin_HTTPS"
    description                = "Allow HTTPS access"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefixes    = var.adminSourceRange
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow_mgmt_SSH"
    description                = "Allow SSH access"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_mgmt_HTTPS"
    description                = "Allow HTTPS access"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_DCD"
    description                = "Allow DCD access"
    priority                   = 104
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9300"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_MONGO"
    description                = "Allow MongoDb access"
    priority                   = 105
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "27017"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  #bigiq 7
  security_rule {
    name                       = "allow_corosync_UDP"
    description                = "Allow corosync access"
    priority                   = 106
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "5404"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  #bigiq 7
  security_rule {
    name                       = "allow_corosync2_UDP"
    description                = "Allow corosync2 access"
    priority                   = 107
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "5405"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  #bigiq 7
  security_rule {
    name                       = "allow_pacemaker_UDP"
    description                = "Allow pacemaker access"
    priority                   = 108
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Udp"
    source_port_range          = "*"
    destination_port_range     = "2224"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  # bigiq 6
  security_rule {
    name                       = "allow_api_TCP"
    description                = "Allow api access"
    priority                   = 109
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "28015"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }
  # bigiq 6
  security_rule {
    name                       = "allow_api2_TCP"
    description                = "Allow api2 access"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "29015"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "*"
  }

  tags = {
    Name        = "${var.environment}-bigiq-sg"
    environment = var.environment
    owner       = var.owner
    group       = var.group
    costcenter  = var.costcenter
    application = var.application
  }
}
