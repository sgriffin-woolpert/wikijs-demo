# wikijs-demo 

This pulls up Wikijs using docker and postgres.

## Requirements

[Azure-cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
[PostgreSQL Client](https://wiki.postgresql.org/wiki/PostgreSQL_Clients)

## Developing Locally

``` 
docker compose up 
```

## Exporting the database from docker

1. Connect to the database container
2. Execute the ```pg_dump``` command

Example:

```
pg_dump --column-inserts --data-only -U wikijs -d wiki > /app/wiki.sql
```

## Deploying to Azure

```
cd terraform
terraform apply 
```

### Notes

- ***Azure Only*** If you see the set up page, create a database to upload in the terraform folder called ``` wikijs_dump.postgres ```
- ***MacOS Only*** Change docker port from 88 to another one
