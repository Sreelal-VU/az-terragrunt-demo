resource "azurerm_network_security_group" "vnet" {
  name                = var.netSecGrp
  location            = var.location
  resource_group_name = var.resource_group_name
}
resource "azurerm_virtual_network" "terragruntvnet" {
    name                = var.vnet_name
    location            = var.location
    resource_group_name = azurerm_resource_group.terragruntvnet.name
    address_space       = ["${var.address_space}"]


  subnet {
    name           = "publicsubnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "publicsubnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "privatesubnet1"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.vnet.id
  }
  subnet {
    name           = "privatesubnet2"
    address_prefix = "10.0.4.0/24"
    security_group = azurerm_network_security_group.vnet.id
  }
  tags = {
    environment = "sreelalvnet"
  }
}