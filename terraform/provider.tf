terraform {
  required_version = "~> 1.0"
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0.0"
    }
  }
  backend "azurerm" {
    storage_account_name = "saterraformneolutin"
    container_name       = "hashicorpvault"
    key                  = "terraform.tfstate"
    access_key           = "__TERRAFORMSTORAGE_KEY__=="
  }
}

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

provider "azuread" {
  tenant_id = "__AZURETENANT_ID__"
}

# Make client_id, tenant_id, subscription_id and object_id variables
data "azurerm_client_config" "current" {}
