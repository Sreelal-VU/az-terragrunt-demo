resource "azurerm_resource_group" "resource_groups" {
  for_each = var.resource_groups

  name     = "${var.common_name_prefix}-${each.value.rsg_app_code}-${var.rsg_suffix}"
  location = var.az_location
  tags     = var.tags
}