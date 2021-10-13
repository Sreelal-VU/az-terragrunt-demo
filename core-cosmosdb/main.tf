resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cosmosdb_account" "cosmos_acc" {
  name                      = local.cosmos_db_account_name
  location                  = var.location
  resource_group_name       = var.resource_group_name
  offer_type                = var.offer_type
  kind                      = var.kind
  enable_automatic_failover = true

  dynamic "geo_location" {
    for_each = var.failover_locations != null ? var.failover_locations : local.default_failover_locations
    content {
      location          = geo_location.value.location
      failover_priority = lookup(geo_location.value, "priority", 0)
      zone_redundant    = lookup(geo_location.value, "zone_redundant", false)
    }
  }

  consistency_policy {
    consistency_level       = var.consistency_policy_level
    max_interval_in_seconds = var.consistency_policy_max_interval_in_seconds
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }
}
resource "azurerm_cosmosdb_sql_database" "db" {
  name                = "products"
  resource_group_name = azurerm_cosmosdb_account.cosmos_acc.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_acc.name
}
resource "azurerm_cosmosdb_sql_container" "coll" {
  name                = "Clothes"
  resource_group_name = azurerm_cosmosdb_account.cosmos_acc.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_acc.name
  database_name       = azurerm_cosmosdb_sql_database.db.name
  partition_key_path  = "/ClothesId"
}
