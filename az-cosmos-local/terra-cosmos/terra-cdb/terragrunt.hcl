
include {
path = find_in_parent_folders("terragrunt_root.hcl")
}

terraform {
source = "/Users/srunnikrishnan/Desktop/Disney/test-cosmos/az-cosmos-local/hux/cosmos"
}

dependency "terra-rg" {
config_path = "/Users/srunnikrishnan/Desktop/Disney/test-cosmos/az-cosmos-local/terra-cosmos/terra-rg"

mock_outputs_allowed_terraform_commands = ["validate", "plan"]
mock_outputs = {
resource_groups = {
shared = {
name = "COSMOS-RSG"
}
}
}
}

inputs = {
resource_group_name = dependency.terra-rg.outputs.resource_groups.shared.name
}

