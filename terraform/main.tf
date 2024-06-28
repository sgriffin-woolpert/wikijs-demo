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

data "azurerm_resource_group" "griffin" {
  name = "griffin"
}

// We can only use this resource group 
// resource_group_name      = data.azurerm_resource_group.griffin.name

# Create PostgreSQL server
resource "azurerm_postgresql_flexible_server" "default" {
  name                   = var.postgresql-server-name
  resource_group_name    = data.azurerm_resource_group.griffin.name
  location               = data.azurerm_resource_group.griffin.location
  version                = var.postgresql-version
  administrator_login    = var.postgresql-admin-login
  administrator_password = var.postgresql-admin-password
  zone                   = "1"
  storage_mb             = 32768
  sku_name               = var.postgresql-sku-name
  backup_retention_days  = 7
}

# Create PostgreSQL database
resource "azurerm_postgresql_flexible_server_database" "mmchlwikijs" {
  name       = var.postgresql-database-name
  server_id  = azurerm_postgresql_flexible_server.default.id
  depends_on = [azurerm_postgresql_flexible_server.default]
}

// Create storage account 
resource "azurerm_storage_account" "chlmmwikijspb" {
  name                     = var.storage_account_name
  resource_group_name      = data.azurerm_resource_group.griffin.name
  location                 = data.azurerm_resource_group.griffin.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

// Creating storage container
resource "azurerm_storage_container" "chlmmwikijs" {
  name                  = var.storage_container_name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}

// Upload local file to Azure blob storage
resource "azurerm_storage_blob" "backup_file" {
  name                   = var.backup_file_path
  type                   = "Block"
  storage_container_name = var.storage_container_name
  storage_account_name   = var.storage_account_name
  // content                = base64encode(file(var.backup_file_path))

  depends_on = [azurerm_postgresql_flexible_server.default]
}

# PostgreSQL Connection security: Allowing access to Azure services  
resource "azurerm_postgresql_flexible_server_firewall_rule" "postgresql_firewall_rule" {
  name             = "Azure_Service_Access"
  server_id        = azurerm_postgresql_flexible_server.default.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

// Import Database from backup 
resource "null_resource" "db_setup" {
  provisioner "local-exec" {
    command = "psql sslmode=require -h mmchlwikijs.postgres.database.azure.com -p 5432 -U ${var.postgresql-admin-login} -d wikijs < ./wikijs_dump.postgres"
    environment = {
      PGPASSWORD = "${var.postgresql-admin-password}"
    }
  }
}
resource "null_resource" "db_verification" {
  provisioner "local-exec" {
    command = "psql -h mmchlwikijs.postgres.database.azure.com -p 5432 -U test -d wikijs -c 'SELECT * FROM users;'"
    environment = {
      PGPASSWORD = "${var.postgresql-admin-password}"
    }
  }
}

# Create a Service Plan for OS Linux
resource "azurerm_service_plan" "servplan" {
  name                = var.service_plan_name
  resource_group_name = data.azurerm_resource_group.griffin.name
  location            = data.azurerm_resource_group.griffin.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku
}

# Create a Linux App Service declaring Application Settings and 
# the Docker image for container build
resource "azurerm_linux_web_app" "appservice" {
  name                = var.app_service_name
  resource_group_name = data.azurerm_resource_group.griffin.name
  location            = data.azurerm_resource_group.griffin.location
  service_plan_id     = azurerm_service_plan.servplan.id

  app_settings = {
    "DB_TYPE" = "postgres"
    "DB_HOST" = "${var.postgresql-server-name}.postgres.database.azure.com"
    "DB_PORT" = 5432
    "DB_NAME" = "${var.postgresql-database-name}"
    "DB_USER" = "${var.postgresql-admin-login}"
    "DB_PASS" = "${var.postgresql-admin-password}"
    "DB_SSL"  = true
  }

  site_config {
    always_on = false
    application_stack {
      docker_image     = "requarks/wiki"
      docker_image_tag = "2.5.303"
    }
  }
}