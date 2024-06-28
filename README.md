# wikijs-demo 

This pulls up Wikijs using docker and postgres. 

## Developing Locally 

``` 
docker compose up 
```
## Deploying to Azure

```
cd terraform

terraform apply 

```
If you see the set up page, create a database to upload in the terraform folder called ``` wikijs_dump.postgres ```
