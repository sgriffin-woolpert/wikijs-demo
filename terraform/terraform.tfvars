
#postgres-settings
postgresql-admin-login    = "test"
postgresql-admin-password = "EndpointBoil-bBhxO9"
postgresql-server-name    = "mmchlwikijs"
postgresql-database-name  = "wikijs"
postgresql-version        = "13"
postgresql-sku-name       = "GP_Standard_D2s_v3"
storage_mb                = "32768"
#fw-rule
first_ip_address = "0.0.0.0"
last_ip_address  = "255.255.255.255" #trick to allow access to Azure services
//storage container 
backup_file_path       = "./wikijs_dump.postgres"
storage_container_name = "dbbackups"
storage_account_name   = "chlmmwikijspb"
#app-service
app_service_name = "chlwikijs"
app_service_plan = "ASP-tcblpwiki"
service_plan_sku = "B1"
db-type          = "postgres"
db-port          = "5432"