locals {

  cosmos_db_account_name = "smartdb1"

  default_failover_locations = {
    default = {
      location = var.resource_group_location
    }
  }
}