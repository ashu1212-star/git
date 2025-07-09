resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = data.azurerm_public_ip.pip.id
  
}
}

data "azurerm_subnet" "subnet" {
    name = "dev-subnet"
    resource_group_name = "dev-rg"
    virtual_network_name = "dev-vnet"
  
}

data "azurerm_public_ip" "pip" {
    name                = "dev-pip"
    resource_group_name = "dev-rg"
}
