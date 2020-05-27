# Configure the Microsoft Azure Provider, replace Service Principal and Subscription with your own
provider "azurerm" {
  version = "=1.38.0"
}
# Create a Resource Group for the new Virtual Machine
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}rg${var.buildSuffix}"
  location = var.location
}

resource "random_pet" "buildSuffix" {
  keepers = {
    # Generate a new pet name each time we switch to a new projectPrefix
    prefix = var.projectPrefix
  }

  separator = "-"
}