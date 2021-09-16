
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
    location = "West Europe"
    resource_group_name = "storage_terraform_rg"
    storage_account_name   = "storageaccountdemodisney"  
    storage_container_name = "my-files"
}
