variable "lambda_function_name" {
  type = string
}
variable "dynamodb_arn" {
  type = string
}
variable "dynamodb_actions" {
  description = "List of DynamoDB actions for the IAM policy"
  type        = list(string)
  default     = ["dynamodb:GetItem", "dynamodb:PutItem"]
}

