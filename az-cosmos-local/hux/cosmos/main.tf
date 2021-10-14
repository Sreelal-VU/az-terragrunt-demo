resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
resource "azurerm_cosmosdb_account" "accdb" {
  name                      = local.cosmos_db_account_name
  location                  = azurerm_resource_group.rg.location
  resource_group_name       = azurerm_resource_group.rg.name
  offer_type                = var.offer_type
  kind                      = var.kind
  enable_automatic_failover = true
  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.failover_location
    failover_priority = 1
  }
  geo_location {
    location          = var.resource_group_location
    failover_priority = 0
  }
}
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "products"
  resource_group_name = azurerm_cosmosdb_account.accdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.accdb.name
}
resource "azurerm_cosmosdb_sql_container" "coll" {
  name                = "Clothes"
  resource_group_name = azurerm_cosmosdb_account.accdb.resource_group_name
  account_name        = azurerm_cosmosdb_account.accdb.name
  database_name       = azurerm_cosmosdb_sql_database.db.name
  partition_key_path  = "/ClothesId"
}