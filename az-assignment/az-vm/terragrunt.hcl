
remote_state {
    backend = "azurerm"
    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "demo1"
        storage_account_name = "terragruntdemo"
        container_name = "tfstate"
        
    }
}

inputs = {
location              = "East US"
rg_name               = "example1"
address_space         = "10.0.0.0/16"
}

