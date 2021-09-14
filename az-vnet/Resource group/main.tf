provider "azurerm" {
  features {}
  version = ">2.56.0"
}
terraform {
  backend "azurerm" {}
}
resource "azurerm_resource_group" "demo2" {
  name     = var.resource_group_name
  location = var.location
}
