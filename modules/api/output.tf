output "api_invoke_url" {
    value       = "https://${aws_api_gateway_rest_api.rest_api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_stage.stage.stage_name}/${aws_api_gateway_resource.items.path_part}"
}
