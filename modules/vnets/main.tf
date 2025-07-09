resource "azurerm_virtual_network" "vnets" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.rg_name

  
}

