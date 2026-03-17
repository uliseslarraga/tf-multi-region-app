# Terraform Multi Region Architecture App

## Requirements 

- AWS Account
- Terraform 

## Project Setup
### Boostrap proyect
Create tf backend s3 bucket with Cloudformation Template to handle bucket state in AWS

```shell
aws cloudformation create-stack --stack-name tf-state-stack --template-body file://bootstrap/backend.yaml --parameters ParameterKey=BucketNameParameter,ParameterValue=<your-bucket-name>
```

### Init proyect 

Get S3 Backend name
```shell
export TF_BACKEND=$(aws cloudformation describe-stacks --stack-name tf-state-stack --query "Stacks[*].Outputs[*].{Value:OutputValue}" --output text)
echo $TF_BACKEND
```