# resource "aws_api_gateway_rest_api" "rest_api" {
#   name = var.api_name
#   endpoint_configuration {
#     types = ["REGIONAL"]
#   }
# }

# resource "aws_api_gateway_resource" "api_resource" {
#   rest_api_id = aws_api_gateway_rest_api.rest_api.id
#   parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
#   path_part   = "items"
# }

# resource "aws_api_gateway_method" "api_method_get" {
#   rest_api_id      = aws_api_gateway_rest_api.rest_api.id
#   resource_id      = aws_api_gateway_resource.api_resource.id
#   http_method      = "GET"
#   authorization    = "NONE"
#   api_key_required = false
# }

# resource "aws_api_gateway_method" "api_method_put" {
#   rest_api_id      = aws_api_gateway_rest_api.rest_api.id
#   resource_id      = aws_api_gateway_resource.api_resource.id
#   http_method      = "PUT"
#   authorization    = "NONE"
#   api_key_required = false  # Added
# }

# resource "aws_api_gateway_integration" "get_lambda" {
#   rest_api_id             = aws_api_gateway_rest_api.rest_api.id
#   resource_id             = aws_api_gateway_resource.api_resource.id
#   http_method             = aws_api_gateway_method.api_method_get.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_invoke_arn}/invocations"
# }

# resource "aws_api_gateway_integration" "put_lambda" {
#   rest_api_id             = aws_api_gateway_rest_api.rest_api.id
#   resource_id             = aws_api_gateway_resource.api_resource.id
#   http_method             = aws_api_gateway_method.api_method_put.http_method
#   integration_http_method = "POST"
#   type                    = "AWS_PROXY"
#   uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_invoke_arn}/invocations"
# }




# resource "aws_api_gateway_stage" "example" {
#   deployment_id = aws_api_gateway_deployment.api_deployment.id
#   rest_api_id   = aws_api_gateway_rest_api.rest_api.id
#   stage_name    = var.environment
# }


# resource "aws_lambda_permission" "allow_apigateway" {
#   statement_id  = "AllowAPIGatewayInvoke"
#   action        = "lambda:InvokeFunction"
#   function_name = var.lambda_function_name
#   principal     = "apigateway.amazonaws.com"
#   source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*"
# }

# resource "aws_api_gateway_deployment" "api_deployment" {
#   rest_api_id = aws_api_gateway_rest_api.rest_api.id
#   triggers = {
#     redeployment = sha1(jsonencode(aws_api_gateway_rest_api.rest_api.body))  # Added
#   }
#   depends_on = [
#     aws_api_gateway_integration.get_lambda,
#     aws_api_gateway_integration.put_lambda
#   ]
#   lifecycle {
#     create_before_destroy = true
#   }
  
# }


////////////////////=-=============================
resource "aws_api_gateway_rest_api" "rest_api" {
  name = var.api_name
   endpoint_configuration {
     types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "items" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  parent_id   = aws_api_gateway_rest_api.rest_api.root_resource_id
  path_part   = "items"
}

resource "aws_api_gateway_method" "get" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "post" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id   = aws_api_gateway_resource.items.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_lambda" {
  rest_api_id   = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.items.id
  http_method             = aws_api_gateway_method.get.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_invoke_arn}/invocations"
}

resource "aws_api_gateway_integration" "post_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.rest_api.id
  resource_id             = aws_api_gateway_resource.items.id
  http_method             = aws_api_gateway_method.post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.lambda_invoke_arn}/invocations"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.rest_api.id
  depends_on = [
    aws_api_gateway_integration.get_lambda,
    aws_api_gateway_integration.post_lambda
  ]
}
resource "aws_api_gateway_stage" "stage" {
  deployment_id    = aws_api_gateway_deployment.api_deployment.id
  rest_api_id      = aws_api_gateway_rest_api.rest_api.id
  stage_name       = var.environment
}
resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.rest_api.execution_arn}/*/*"
}
