terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {}
}
resource "azurerm_storage_account" "example" {
  name                     = "storage-acc-tf"
  resource_group_name      = "session21"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "example" {
  name                  = "storage-container-tf"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "blob"
}
