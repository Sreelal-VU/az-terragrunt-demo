variable "location" {
  description = "The Azure Region in which the Resource Group exists"
}

variable "rg_name" {
  description = "The name of the Resource Group where VM resources will be created"
}


variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = ""
}

