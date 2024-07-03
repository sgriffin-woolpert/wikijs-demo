// postgres settings
variable "postgresql-admin-login" {
}
variable "postgresql-admin-password" {
}
variable "postgresql-version" {
}
variable "postgresql-sku-name" {
}
variable "storage_mb" {
}
variable "postgresql-server-name" {
}
variable "postgresql-database-name" {
}

// fw-rules
variable "first_ip_address" {
}
variable "last_ip_address" {
}

//storage container
variable "backup_file_path" {
}
variable "storage_container_name" {
}
variable "storage_account_name" {
}

// app-service 
variable "app_service_plan" {
}
variable "service_plan_sku" {
}
variable "app_service_name" {
}
variable "db-port" {
}
variable "db-type" {
}
