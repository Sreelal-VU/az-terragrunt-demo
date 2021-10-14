# Enforce a minimum terraform version
#terraform_version_constraint = ">= 0.14.7, <0.15"

# Enforce a minimum terragrunt version
#terragrunt_version_constraint = ">= 0.28.7"

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
  location    = yamldecode(file(find_in_parent_folders("location.yaml")))
  secrets     = yamldecode(sops_decrypt_file(find_in_parent_folders("secrets.yaml")))
}

remote_state {
  backend = "azurerm"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    tenant_id            = "${local.secrets.tenant_id}"
    subscription_id      = "${local.secrets.subscription_id}"
    resource_group_name  = "${upper(local.common_vars.delivery)}-EU2-TFSTATE-RSG"
    storage_account_name = "${lower(local.common_vars.delivery)}eu2tfstatesa"
    container_name       = "${lower(local.common_vars.delivery)}"
    key                  = "${path_relative_to_include()}/terraform.state"
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "azurerm" {
      tenant_id       = "${local.secrets.tenant_id}"
      subscription_id = "${local.secrets.subscription_id}"

      features {
        key_vault {
          recover_soft_deleted_key_vaults = false
          purge_soft_delete_on_destroy    = true
        }
      }
    }
EOF
}

inputs = merge(
  local.common_vars,
  local.location,
  {
    common_name_prefix    = "${upper(local.common_vars.delivery)}-EU2"
    no_hyphen_name_prefix = "${lower(local.common_vars.delivery)}eu2"
    vm_name_prefix        = "${upper(local.common_vars.delivery)}EU2"
    vnet_name_prefix      = "${upper(local.common_vars.vnet_name)}-EU2"

    kv_access_policy_object_id  = local.secrets.kv_access_policy_object_id
    kv_access_policy_object_ids = local.secrets.kv_access_policy_object_ids

    tags = local.common_vars.common_tags
  }
)