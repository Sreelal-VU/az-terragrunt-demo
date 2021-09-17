  resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acr" {
  name                = "AzureCRacr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = var.sku
  admin_enabled       = false
  georeplications = [
    {
      location                = "East US"
      zone_redundancy_enabled = true
      tags                    = {}
    }]
}