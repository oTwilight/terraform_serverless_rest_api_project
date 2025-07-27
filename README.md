### Serverless REST API on AWS (Terraform)

This project deploys a serverless REST API using AWS Lambda, DynamoDB, and API Gateway. Infrastructure is provisioned via Terraform.

---

### Project Structure

project-root/
├── modules/
│   ├── dynamodb/
│   ├── iam/
│   ├── lambda/
│   └── apigateway/
├── envs/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── terraform.tfvars
└── README.md

---

## Features

Serverless Lambda Function

IAM Role with Least Privilege

DynamoDB table with on-demand billing

API Gateway (REST) Integration

Environment-based separation

Fully modular structure

## Prerequisites

Terraform >= 1.3

AWS CLI configured (aws configure)

Python (for local zip packaging, if needed)

zip installed (sudo apt install zip or brew install zip)

```bash
1. Clone the Repository

git clone https://github.com/your-repo/terraform-serverless-api.git
cd terraform-serverless-api/envs/dev

2. Initialize Terraform

terraform init

3. Format and Validate

terraform fmt
terraform validate

4. Plan Infrastructure

terraform plan -var-file="terraform.tfvars"

5. Apply Infrastructure

terraform apply -var-file="terraform.tfvars"


6. Destroy Infrastructure

terraform destroy -var-file="terraform.tfvars"

 Inputs (in terraform.tfvars)

environment           = "dev"
lambda_function_name  = "my-serverless-api"
db_table_name         = "my-items-table"

API Usage
POST /items

curl -X POST $API_URL/items \
  -H "Content-Type: application/json" \
  -d '{"id": "1", "data": "hello"}'

GET /items?id=1


curl -X GET "$API_URL/items?id=1"