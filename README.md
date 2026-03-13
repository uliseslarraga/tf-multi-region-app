# Terraform Multi Region Architecture App

## Requirements 

- AWS Account
- Terraform 

## Project Setup
Create tf backend s3 bucket with Cloudformation Template to handle bucket state in AWS

```shell
aws cloudformation create-stack --stack-name tf-state-stack --template-body file://bootstrap/backend.yaml --parameters ParameterKey=BucketNameParameter,ParameterValue=<your-bucket-name>
```
