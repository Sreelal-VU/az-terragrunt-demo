module "aks" {
  source              = "./aks"
  resource_group_name = "aks_terraform_rg"
  location            = "West US"
  cluster_name        = "terraform-aks"
  kubernetes_version  = "1.19.13"
  system_node_count   = 2
  node_resource_group = "aks_terraform_resources_rg"
}

module "acr" {
  source              = "./acr" 
  sku                 = "Premium"
  resource_group_name = "acr_rg"
  location            = "East US"
}
