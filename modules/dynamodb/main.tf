resource "aws_dynamodb_table" "dynamodb_table" {
  name = var.dynamodb_table_name
  billing_mode   = var.billing_mode
  hash_key       = var.partition_key
  attribute {
    name = var.partition_key
    type = var.type_of_partition_key
  }
  tags = local.common_tags
}


