terraform {
  backend "azurerm" {
    resource_group_name  = "rg-ravi"
    storage_account_name = "storagetechaccount"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}
