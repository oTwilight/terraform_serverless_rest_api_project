output "api_invoke_url" {
  value = module.api.api_invoke_url
}

output "dynamodb_table_name" {
  value = module.dynamodb.dynamodb_table_name
}

output "lambda_arn" {
  value = module.lambda.lambda_function_arn
}
