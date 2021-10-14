/*
 * Generic Resource Variables
 */
variable "az_location" {
  description = "String description/syntax for Azure region location"
  type        = string
}

variable "common_name_prefix" {
  description = "Terragrunt dynamic naming construct for common Azure resources"
  type        = string
}

variable "tags" {
  description = "Object set for descriptive tags for Azure resources & resource groups"
  type        = map(string)
  default     = null
}

/*
 * Resource Group Variables
 */

variable "rsg_suffix" {
  description = "Suffix for resource groups"
  type        = string
  default     = "RSG"
}

variable "resource_groups" {
  description = "Short-hand code for descriptive name of app for resource group e.g. API, UI, NET, SQL, etc"
  type        = map(any)
  default = {
    shared = {
      rsg_app_code = "SHARED"
    },
    net = {
      rsg_app_code = "NET"
    },
    functions = {
      rsg_app_code = "FUNCTIONS"
    },
    iaas = {
      rsg_app_code = "IAAS"
    }
  }
}