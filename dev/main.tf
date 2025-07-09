module "rg" {
    source = "../modules/RG"
    rg_name = "dev-rg"
    location = "East US"
  
}
module "rg" {
    source = "../modules/RG"
    rg_name = "dev-rg"
    location = "East US"
  
}

module "rg2" {
    source = "../modules/RG"
    rg_name = "dev-rg2"
    location = "East US"
  
}

module "vnet" {
    depends_on = [ module.rg ]
  source = "../modules/vnets"
    vnet_name = "dev-vnet"
    rg_name = "dev-rg"
    location = "East US"
    address_space = ["10.0.0.0/20"]
}

module "vnet2" {
    depends_on = [ module.rg ]
  source = "../modules/vnets"
    vnet_name = "dev-vnet2"
    rg_name = "dev-rg"
    location = "East US"
    address_space = ["10.0.0.0/20"]
}

module "subnet" {
    depends_on = [ module.vnet ]
    source = "../modules/subnets"
    subnet_name = "dev-subnet"
    vnet_name = "dev-vnet"
    rg_name = "dev-rg"
    address_prefixes = ["10.0.0.0/24"]
  
}

module "mssqlserver" {
    depends_on = [ module.subnet ]
    source = "../modules/sqlserver"
    sql_server_name = "dev-sqlserver10"
    rg_name = "dev-rg"
    location = "west us2"
    administrator_login = "sqladmin"
    administrator_login_password = "Password1234!"
    sqlversion = "12.0"
}

module "sqldatabase" {
    depends_on = [ module.mssqlserver, module.subnet , module.vnet , module.rg ]
  source = "../modules/sqldatabase"
    sql_database_name  = "dev-sqldatabase"
}
module "pip" {
    depends_on = [ module.vnet ]
  source = "../modules/publicip"
    rg_name = "dev-rg"
    location = "East US"
    public_ip_name   = "dev-pip"
    allocation_method = "Static"
    sku = "Standard"

}

module "nic" {
    depends_on = [ module.subnet, module.pip , module.rg ]
  source = "../modules/nic"
    nic_name = "dev-nic"
    location = "East US"
    rg_name = "dev-rg"
    ip_configuration_name = "ipconfig1"
    private_ip_address_allocation = "Dynamic"
}

module "keyvault" {
    depends_on = [ module.rg ]
    source = "../modules/key_vault"
    key_vault_name = "dev-keyvault101100"
    rg_name = "dev-rg"
    location = "East US"
}

module "key_vault_secret" {
    depends_on = [ module.keyvault ]
  source = "../modules/keyvault_secret"
  }

# module "key_vault_secret" {
#     depends_on = [ module.keyvault ]
#   source = "../modules/keyvault_secret"
#     key_vault_name = "dev-keyvault"
#     rg_name = "dev-rg"
# }




module "vm" {
    depends_on = [ module.nic , module.key_vault_secret, module.rg ]
    source = "../modules/vm"
    vm_name = "dev-vm"
    rg_name = "dev-rg"
    location = "East US"

    vm_size = "Standard_B1s"
}