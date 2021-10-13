locals {

  cosmos_db_account_name = "Give the name"

  default_failover_locations = {
    default = {
      location = var.location
    }
  }
}
