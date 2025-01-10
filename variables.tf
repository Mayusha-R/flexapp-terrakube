# General
variable "location" {
  type = string
}
variable "rg_name" {
  type = string
}
variable "resource_owner" {
  type = string
}
variable "business_unit" {
  type = string
}
variable "project_name" {
  type = string
}
variable "delivery_manager" {
  type = string
}
variable "create_date" {
  type = string
}

# Storage
variable "storageAccount_name" {
  type = string
}
variable "storageAccount_tier" {
  type = string
}
variable "storageAccount_replication_type" {
  type = string
}

# Service Plan
variable "servicePlan_name" {
  type = string
}
variable "servicePlan_os_type" {
  type = string
}
variable "servicePlan_sku" {
  type = string
}

# Function App
variable "functionApp_name" {
  type = string
}
