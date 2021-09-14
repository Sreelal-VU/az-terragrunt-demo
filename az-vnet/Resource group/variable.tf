  
variable location {
    description = "Location of the Virtual Net"
}

variable resource_group_name {
    description = "Resource Group Name for the virtual net"
}

variable nsg_name {
    description = "Network Security Group Name for the virtual net"
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = ""
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = ""
}