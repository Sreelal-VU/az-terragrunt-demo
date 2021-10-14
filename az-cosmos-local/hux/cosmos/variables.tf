
variable "subscription_id" {
  default = "84851fb3-6fbc-42b2-9783-5c66d2ffd98b"
}

variable "tenant_id" {
  default = "36da45f1-dd2c-4d1f-af13-5abe46b99921"
}

variable "resource_group_name" {
  default = "ValidaCosmosDBTerraform-rg"
}
variable "resource_group_location" {
  default = "australiaeast"
}

variable "failover_location" {
  default = "australiasoutheast"
}

variable "offer_type" {
  type        = string
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard."
  default     = "Standard"
}

variable "kind" {
  type        = string
  description = "Specifies the Kind of CosmosDB to create - possible values are `GlobalDocumentDB` and `MongoDB`."
  default     = "GlobalDocumentDB"
}