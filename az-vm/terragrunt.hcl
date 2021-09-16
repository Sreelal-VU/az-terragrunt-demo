
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
location              = "West Europe"
rg_name               = "bigdata"
name                  = "master"
size                  = "Standard_A1_v2"
count                 = "4"
subdomain             = "mysubdomain"
subnet_id             = "..."
admin_username        = "toto"
admin_password        = "P@ssword$1234"
network               = "10.2.1.0/24"
start_ip              = "10"
tags                  = {
                               environment = "test"
                               project = "test"
                       }
}

