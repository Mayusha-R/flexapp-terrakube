locals {
  common_tags = {
    ResourceOwner   = var.resource_owner
    DeliveryManager = var.delivery_manager
    ProjectName     = var.project_name
    BusinessUnit    = var.business_unit
    CreateDate      = var.create_date
  }
}

module "storage" {
  source           = "./modules/storage"
  location         = var.location
  rg_name          = var.rg_name
  storage_name     = var.storageAccount_name
  account_tier     = var.storageAccount_tier
  replication_type = var.storageAccount_replication_type
  tags             = local.common_tags
}

module "servicePlan" {
  source   = "./modules/servicePlan"
  location = var.location
  rg_name  = var.rg_name
  name     = var.servicePlan_name
  os_type  = var.servicePlan_os_type
  sku      = var.servicePlan_sku
  tags     = local.common_tags
}

module "functionApp" {
  source                            = "./modules/functionApp"
  location                          = var.location
  rg_name                           = var.rg_name
  name                              = var.functionApp_name
  storage_account_name              = module.storage.name
  service_plan_id                   = module.servicePlan.plan_id
  storage_account_connection_string = module.storage.connection_string
  storage_account_id                = module.storage.id
  tags                              = local.common_tags

}