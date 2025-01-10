resource "azurerm_storage_account" "storage" {
  name                     = var.storage_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  tags                     = var.tags
}

# resource "azurerm_storage_container" "main_container" {
#   name                  = "app-pakage-flexconsumption"
#   storage_account_id    = azurerm_storage_account.storage.id
#   container_access_type = "private"
# }

