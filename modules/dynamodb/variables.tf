variable "dynamodb_table_name" {
  type = string
}
variable "partition_key" {
  type = string
}
variable "type_of_partition_key" {
  description = "DynamoDB requires you to define the data type for each attribute used as a key (partition key or sort key"
  type = string
}
variable "billing_mode" {
  type = string
}
variable "environment" {
  type = string
}