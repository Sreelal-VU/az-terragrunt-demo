remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "demo1"
        storage_account_name = "azdisney"
        container_name = "democontainer"
    }
}

inputs = {
location = "West US"
resource_group_name = "demo3"
netSecGrp = "vnet"
vnet_name = "terragruntvnet"
address_space = "10.0.0.0/16"
}
