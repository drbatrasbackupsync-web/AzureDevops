terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ravi"
    storage_account_name = "storagetechaccounts"
    container_name       = "tfstate"
    key                  = "preprod.terraform.tfstate"
  }
}
