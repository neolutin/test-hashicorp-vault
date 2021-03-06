#Set the terraform required version
terraform {
  required_version = "~> 1.0"
  backend "azurerm" {
    storage_account_name = "saterraformneolutin"
    container_name       = "hashicorpvault"
    key                  = "__GITHUB_WORKFLOW__/__RESOURCES_NAME__.tfstate"
    access_key           = "__TERRAFORMSTORAGE_KEY__=="
  }
}

# Azure Provider
provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
  skip_provider_registration = "true"
  environment                = "public"
  tenant_id                  = "__AZURETENANT_ID__"
  subscription_id            = "__AZURESUSCRIPTION_ID__"
  client_id                  = "__TERRAFORMCLIENT_ID__"
  client_secret              = "__TERRAFORMCLIENT_SECRET__"
}

# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}
