

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
    resource_group_name = "aks_terraform_rg"
    location            = "West US"
    cluster_name        = "terraform-aks"
    kubernetes_version  = "1.19.13"
    system_node_count   = 2
    node_resource_group = "aks_terraform_resources_rg"
    sku                 = "Premium"
}

