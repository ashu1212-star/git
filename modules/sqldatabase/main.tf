resource "azurerm_mssql_database" "sqldb" {
  name         = var.sql_database_name
  server_id    = data.azurerm_mssql_server.sqlserver.id
  collation    = "SQL_Latin1_General_CP1_CI_AS" 
  license_type = "LicenseIncluded"
  max_size_gb  = 5
  sku_name     = "S0"
  enclave_type = "VBS"
  
}

data "azurerm_mssql_server" "sqlserver" {
    name = "dev-sqlserver10"
  resource_group_name = "dev-rg"
}

