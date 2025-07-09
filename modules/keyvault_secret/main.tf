 data "azurerm_key_vault" "kv" {
  name                = "dev-keyvault101100"
  resource_group_name = "dev-rg"
}
  resource "azurerm_key_vault_secret" "secret1" {
  name         = "username"
  value        = "adminuser"
  key_vault_id = data.azurerm_key_vault.kv.id
}


resource "azurerm_key_vault_secret" "secret2" {
  name         = "password"
  value        = "Test@1234"
  key_vault_id = data.azurerm_key_vault.kv.id
}