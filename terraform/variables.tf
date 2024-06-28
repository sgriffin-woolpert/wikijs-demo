variable "postgresql-admin-login" {
  type        = string
  description = "Login to authenticate to PostgreSQL Server"
  default     = "test"
}
variable "postgresql-admin-password" {
  type        = string
  description = "Password to authenticate to PostgreSQL Server"
  default     = "EndpointBoil-bBhxO9"
}
variable "postgresql-version" {
  type        = string
  description = "PostgreSQL Server version to deploy"
  default     = "13"
}
variable "postgresql-sku-name" {
  type        = string
  description = "PostgreSQL SKU Name"
  default     = "GP_Standard_D2s_v3"
  // B1ms - change to correct size
}
variable "storage_mbps" {
  type        = string
  description = "PostgreSQL Storage throughput"
  default     = "200"
}
variable "postgresql-server-name" {
  type        = string
  description = "Name of Postgres Database server"
  default     = "mmchlwikijs"
}
variable "postgresql-database-name" {
  type        = string
  description = "Name of Postgres Database server"
  default     = "wikijs"
}
variable "firewall-rules" {
  type        = string
  description = "Put your description here"
  default     = "fw-rules"
}
variable "first_ip_address" {
  type        = string
  description = "Put your description here"
  default     = "10.0.0.1"
}
variable "last_ip_address" {
  type        = string
  description = "Put your description here"
  default     = "10.0.0.2"
}
variable "backup_file_path" {
  type        = string
  description = "Local file system path for database template"
  default     = "./wikijs_dump.postgres"
}
variable "storage_container_name" {
  type        = string
  description = "Azure container for backups"
  default     = "dbbackups"
}
variable "storage_account_name" {
  type        = string
  description = "Azure storage account for db backups"
  default     = "chlmmwikijspb"
}
variable "service_plan_name" {
  type        = string
  default     = "ASP-tcblpwiki"
  description = "Name of the App Service Web App."
}
variable "service_plan_sku" {
  type        = string
  default     = "B1"
  description = "SKU of the App Service Web App."
}
variable "app_service_name" {
  type        = string
  default     = "chlwikijs"
  description = "Name of the App Service Web App."
}
