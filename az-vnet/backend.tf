# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "azurerm" {
    container_name       = "democontainer"
    key                  = "./terraform.tfstate"
    resource_group_name  = "demo1"
    storage_account_name = "azdisney"
  }
}
