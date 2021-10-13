locals {
  name_prefix = var.name_prefix != "" ? replace(var.name_prefix, "/[a-z0-9]$/", "$0-") : ""

  cosmos_db_account_name = "sampledb"

  default_failover_locations = {
    default = {
      location = var.location
    }
  }
}