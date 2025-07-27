variable "region" {
  description = "our region name"
  type        = string
  default     = "your_region"
}
variable "db_table_name" {
  type = string
  default = "your_db_table_name"
}
variable "environment" {
  type    = string
  default = "your_env_name"
}
variable "lambda_function_name" {
  type = string
  default = "your lambda funtion name"
}
