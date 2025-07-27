
variable "lambda_role_arn" {
  type = string
}
variable "lambda_function_name" {
  type = string
}
variable "lambda_handler_name" {
  type = string
}

variable "environment" {
  type = string
}
variable "python_version" {
  type = string
}
variable "source_code" {
  type = string
  
}
variable "dynamodb_table_name" {
  type = string
}