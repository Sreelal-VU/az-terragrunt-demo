resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  resource_group_name = azurerm_resource_group.terragruntvnet.name
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = "${azurerm_resource_group.main.name}"
  virtual_network_name = "${azurerm_virtual_network.main.name}"
  address_prefix       = "10.0.17.0/24"
}

resource "azurerm_public_ip" "public_ip" {
  count                        = var.count
  name                         = "vm_${var.name}${count.index}_public_ip"
  location                     = var.location
  resource_group_name          = var.rg_name
  public_ip_address_allocation = "dynamic"
  domain_name_label            = "${var.subdomain}-${var.name}${count.index}"
  tags                         = var.tags
}

resource "azurerm_network_interface" "interface" {
  count                   = var.count
  name                    = "vm_${var.name}${count.index}_interface"
  location                = var.location
  resource_group_name     = var.rg_name
  internal_dns_name_label = "${var.name}${count.index}"
  ip_configuration {
    name                          = "private"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "static"
    private_ip_address            = cidrhost(var.network, count.index + var.start_ip)
    public_ip_address_id          = element(azurerm_public_ip.public_ip.*.id, count.index)
  }
  tags = var.tags
}

resource "azurerm_virtual_machine" "vm" {
  count                            = var.count
  name                             = "vm_${var.name}${count.index}"
  location                         = var.location
  resource_group_name              = var.rg_name
  network_interface_ids            = ["${element(azurerm_network_interface.interface.*.id, count.index)}"]
  vm_size                          = var.size
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7-CI"
    version   = "latest"
  }
  storage_os_disk {
    name              = "vm_${var.name}${count.index}_disk_system"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  storage_data_disk {
    name              = "vm_${var.name}${count.index}_disk_data"
    caching           = "ReadWrite"
    create_option     = "Empty"
    disk_size_gb      = var.data_disk_size
    lun               = 1
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.name}${count.index}${var.private_domain == "" ? "" : ".${var.private_domain}"}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}