variable "lambda_function_name" {
  type = string
}
variable "dynamodb_arn" {
  type = string
}
variable "dynamodb_actions" {
  type = list(string)
}
variable "role_json" {
  type = string
}

variable "policy_json" {
  type = string
}

