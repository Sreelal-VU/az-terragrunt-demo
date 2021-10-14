output "resource_groups" {
  value = {
    for key, value in azurerm_resource_group.resource_groups :
    key => {
      name     = value.name
      id       = value.id
      location = value.location
    }
  }
}

output "resource_group_names" {
  description = "Names of the Resource Groups that were provisioned"
  value       = { for name, value in azurerm_resource_group.resource_groups : name => value.name }
}

output "resource_group_ids" {
  description = "Ids of the Resource Groups that were provisioned"
  value       = { for name, value in azurerm_resource_group.resource_groups : name => value.id }
}