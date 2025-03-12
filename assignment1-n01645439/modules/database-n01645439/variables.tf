variable "location" {
  description = "The Azure region to deploy the resources in"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "db_server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "db_admin_username" {
  description = "The administrator username for the PostgreSQL server"
  type        = string
}

variable "db_admin_password" {
  description = "The administrator password for the PostgreSQL server"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the PostgreSQL database to create"
  type        = string
}

variable "tags" {
  description = "value of the tags"
  type        = map(string)
}
