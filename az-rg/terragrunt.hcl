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
    location = "eastus"
    resource_group_name = "demo2"
}
