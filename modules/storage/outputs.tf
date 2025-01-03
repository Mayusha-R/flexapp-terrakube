output "name" {
  value = azurerm_storage_account.storage.name
}
output "primary_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}
# output "blob_name" {
#   value = azurerm_storage_blob.example.name
# }
# output "blob_endpoint" {
#   value = azurerm_storage_account.main_storage.primary_blob_endpoint
# }
# output "container_name" {
#   value = azurerm_storage_container.main_container.name
# }
output "connection_string" {
  value = azurerm_storage_account.storage.primary_connection_string
}
output "id" {
  value = azurerm_storage_account.storage.id
}