module "aws_lambda_role" {
  source             = "git@github.com:Basillica/roles-terraform-module.git"
  create_lambda_role = var.create_lambda_role
  lambda_role_name   = "${var.function_name}_role"
  lambda_policy_file = var.lambda_policy_file
}

module "cloudwatch" {
  create_cloudwatch   = true
  path                = var.cloudwatch_path
  source              = "git@github.com:Basillica/cloudwatch-terraform-module.git"
  resource_name       = var.function_name
  retention_in_days   = 14
  iam_policy_log_name = "${var.function_name}_policy"
  role_name           = module.aws_lambda_role.iam_role_name
  policy_file         = var.cloudwatch_policy_file
}

resource "aws_lambda_function" "lambda" {
  filename      = data.archive_file.lambda_source.output_path
  function_name = var.function_name
  role    = module.aws_lambda_role.iam_role_arn
  handler = var.handler

  runtime       = var.runtime
  architectures = var.architectures
  description   = var.description
  memory_size   = var.memory_size
  timeout       = 300
  source_code_hash = data.archive_file.lambda_source.output_base64sha256
  # Lambda layer 
  layers = (var.lambda_layer_arn[0] != "" ? var.lambda_layer_arn : [""])

  # attach dependencies
  depends_on = [
    null_resource.install_python_dependencies
  ]
  environment {
    variables = var.environment_variables
  }
}