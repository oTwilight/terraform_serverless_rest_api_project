module "dynamodb" {
  source                = "../../modules/dynamodb"
  dynamodb_table_name   = var.db_table_name
  environment           = var.environment
  partition_key       = "id"
}
module "iam" {
  source               = "../../modules/iam"
  lambda_function_name = var.lambda_function_name
  dynamodb_arn         = module.dynamodb.dynamodb_arn
  dynamodb_actions = ["dynamodb:GetItem", "dynamodb:PutItem", "dynamodb:Scan"]
}
module "lambda" {
  source               = "../../modules/lambda"
  dynamodb_table_name = module.dynamodb.dynamodb_table_name
  lambda_role_arn      = module.iam.role_arn
  lambda_function_name = var.lambda_function_name
  lambda_handler_name  = "lambda_handler.lambda_handler"
  source_code          = "../../modules/lambda/code_functions/lambda_handler.zip"
  python_version       = "python3.9"
  environment          = var.environment

}

module "api" {
  source               = "../../modules/api"
  lambda_invoke_arn    = module.lambda.lambda_function_arn
  lambda_function_name = var.lambda_function_name
  environment = var.environment
  region  = var.region
  api_name = "my-rest-api"
}
