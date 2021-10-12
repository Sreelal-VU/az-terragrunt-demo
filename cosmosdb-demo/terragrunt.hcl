terraform {
  source = "/Users/srunnikrishnan/Desktop/Disney/TOCDM-343/cosmosdb-demo"
}
   
remote_state {
    backend = "azurerm"
      generate = {
         path      = "backend.tf"
         if_exists = "overwrite_terragrunt"
  }

    config = {
        key = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name = "localtestingaz"
        storage_account_name = "localtestingaz1"
        container_name = "tfstate"
        sas_token = "sp=racwdl&st=2021-10-12T09:34:35Z&se=2021-10-15T17:34:35Z&sv=2020-08-04&sr=c&sig=s%2BnR3gFHOXlSmH%2FHI1xTD87cRgDjL6A9vwvGu1RQ57c%3D"
    }
}

  
  inputs = {
       resource_group_name             = "DemoCosmosDBTerraform-rg1"
       resource_group_location         = "australiaeast"
       cosmos_db_account_name           = "democosmosterraform2"
       failover_location               = "westus"

  }
