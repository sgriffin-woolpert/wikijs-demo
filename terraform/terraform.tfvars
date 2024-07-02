
#postgres-settings
postgresql-server-name = "mmchlwikijs"
postgresql-version     = "13"
postgresql-sku-name    = "GP_Standard_D2s_v3"
#fw-rule
first_ip_address = "0.0.0.0"
last_ip_address  = "255.255.255.255" #trick to allow access to Azure services
#app-service
db-type = "postgres"
db-port = "5432"