output "function_architecture" {
  description = "The ARN of the Lambda function"
  value       = aws_lambda_function.lambda.architectures
}

output "function_invoke_arn" {
  description = "The Invoke ARN of the Lambda function"
  value       = aws_lambda_function.lambda.invoke_arn
}

output "function_qualified_arn" {
  description = "The qualified ARN of the Lambda function"
  value       = aws_lambda_function.lambda.arn
}

output "role_arn" {
  description = "The ARN of the IAM role created for the Lambda function"
  value       = module.aws_lambda_role.iam_role_arn
}

output "role_name" {
  description = "The name of the IAM role created for the Lambda function"
  value       = module.aws_lambda_role.iam_role_name
}

output "function_name" {
  description = "Name of lambda function"
  value       = join("", concat(aws_lambda_function.lambda.*.function_name, aws_lambda_function.lambda.*.function_name))
}

output "function_arn" {
  description = "AWS arn of lambda function"
  value       = join("", concat(aws_lambda_function.lambda.*.arn, aws_lambda_function.lambda.*.arn))
}
