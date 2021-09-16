resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "demodisneystorage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}

resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.demodisneystorage.name
  container_access_type = "container"
}

resource "azurerm_storage_blob" "blob" {
  name                   = "sample-file"
  storage_account_name   = azurerm_storage_account.demodisneystorage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
}

resource "azurerm_storage_queue" "queue" {
  name                 = "sample-file"
  storage_account_name = azurerm_storage_account.demodisneystorage.name
}

resource "azurerm_storage_share" "fileshare" {
  name                 = "sample-file"
  storage_account_name = azurerm_storage_account.demodisneystorage.name
}

resource "azurerm_storage_table" "table" {
  name                 = "sampletable"
  storage_account_name = azurerm_storage_account.demodisneystorage.name
}




