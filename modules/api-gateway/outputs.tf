output "api_id" {
  description = "ID of the API Gateway HTTP API."
  value       = aws_apigatewayv2_api.this.id
}

output "api_arn" {
  description = "ARN of the API Gateway HTTP API."
  value       = aws_apigatewayv2_api.this.arn
}

output "api_name" {
  description = "Name of the API Gateway HTTP API."
  value       = aws_apigatewayv2_api.this.name
}

output "api_endpoint" {
  description = "Default endpoint of the API Gateway HTTP API."
  value       = aws_apigatewayv2_api.this.api_endpoint
}

output "integration_id" {
  description = "ID of the Lambda API Gateway integration."
  value       = aws_apigatewayv2_integration.lambda.id
}

output "route_id" {
  description = "ID of the API Gateway route."
  value       = aws_apigatewayv2_route.this.id
}

output "stage_id" {
  description = "ID of the API Gateway stage."
  value       = aws_apigatewayv2_stage.default.id
}