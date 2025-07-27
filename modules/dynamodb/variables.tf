variable "dynamodb_table_name" {
  type = string
}
variable "partition_key" {
  type = string
 # default = "id"  if you want change it in root main.tf file to yours
}
variable "environment" {
  type = string
}