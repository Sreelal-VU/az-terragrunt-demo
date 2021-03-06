provider "azurerm" {
  features {}
}
terraform {
  backend "azurerm" {}
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.50.0"
    }
  }
}