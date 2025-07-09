resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  resource_group_name   = var.rg_name
  location              = var.location
  size                  = var.vm_size
  admin_username        = data.azurerm_key_vault_secret.secret1.value
  admin_password        = data.azurerm_key_vault_secret.secret2.value
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  disable_password_authentication = false
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  }

  data "azurerm_network_interface" "nic" {
    name = "dev-nic"
    resource_group_name = "dev-rg"
    
  }

data "azurerm_key_vault" "kv" {
  name                = "dev-keyvault101100"
  resource_group_name = "dev-rg"

}
 
data "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  key_vault_id = data.azurerm_key_vault.kv.id
  
}

data "azurerm_key_vault_secret" "secret2" {
  name = "password"
  key_vault_id = data.azurerm_key_vault.kv.id
}