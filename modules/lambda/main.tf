resource "aws_lambda_function" "lambda_function" {
  filename         = var.source_code
  function_name    = var.lambda_function_name
  role             = var.lambda_role_arn
  handler          = var.lambda_handler_name
  runtime          = var.python_version

  environment {
    variables = {
      DYNAMODB_TABLE = var.dynamodb_table_name
    }
  }
  tags = {
    Environment = var.environment
  }
}






//----- if you need to use multiple lambda functions use this part of code  -----//

# resource "aws_lambda_function" "this" {
#   for_each = var.lambda_functions

#   function_name = each.key
#   handler       = each.value.handler
#   runtime       = each.value.runtime
#   role          = var.lambda_role_arn
#   filename      = each.value.filename

#   environment {
#     variables = {
#       DYNAMODB_TABLE = var.dynamodb_table_name
#     }
#   }

#   tags = {
#     Environment = var.environment
#   }
# }

#and also add the needed variables 

# variable "lambda_functions" {
#   description = "Map of Lambda function configurations"
#   type = map(object({
#     handler  = string
#     runtime  = string
#     filename = string
#   }))
# }


# variable "dynamodb_table_name" {
#   description = "Name of the DynamoDB table"
#   type        = string
# }

#and outputs

# output "lambda_arns" {
#   value = { for k, v in aws_lambda_function.this : k => v.arn }
# }