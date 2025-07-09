resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sql_server_name
  resource_group_name          = var.rg_name
  location                     = var.location
  version                      = var.sqlversion
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  
}

