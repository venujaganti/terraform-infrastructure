resource "aws_apigatewayv2_api" "this" {
  name          = local.api_name
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = var.cors_allow_origins

    allow_methods = [
      "GET",
      "POST",
      "PUT",
      "PATCH",
      "DELETE",
      "OPTIONS"
    ]

    allow_headers = [
      "content-type",
      "authorization"
    ]

    max_age = 300
  }

  tags = merge(
    local.common_tags,
    {
      Name = local.api_name
    }
  )
}

resource "aws_apigatewayv2_integration" "lambda" {
  api_id = aws_apigatewayv2_api.this.id

  integration_type = "AWS_PROXY"
  integration_uri  = var.lambda_invoke_arn

  integration_method = "POST"

  payload_format_version = "2.0"

  timeout_milliseconds = 30000
}

resource "aws_apigatewayv2_route" "this" {
  api_id = aws_apigatewayv2_api.this.id

  route_key = var.route_key

  target = "integrations/${aws_apigatewayv2_integration.lambda.id}"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.this.id

  name = "$default"

  auto_deploy = true

  dynamic "access_log_settings" {
    for_each = var.enable_access_logs ? [1] : []

    content {
      destination_arn = aws_cloudwatch_log_group.api[0].arn

      format = jsonencode({
        requestId               = "$context.requestId"
        sourceIp                = "$context.identity.sourceIp"
        requestTime             = "$context.requestTime"
        httpMethod              = "$context.httpMethod"
        routeKey                = "$context.routeKey"
        status                  = "$context.status"
        protocol                = "$context.protocol"
        responseLength          = "$context.responseLength"
        integrationErrorMessage = "$context.integrationErrorMessage"
      })
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-api-stage"
    }
  )
}

resource "aws_cloudwatch_log_group" "api" {
  count = var.enable_access_logs ? 1 : 0

  name              = "/aws/apigateway/${local.api_name}"
  retention_in_days = 30

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-api-logs"
    }
  )
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "${local.name_prefix}-api-gateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.this.execution_arn}/*/*"
}