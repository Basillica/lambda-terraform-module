# General Variables

variable "region" {
  description = "Default region for provider"
  type        = string
  default     = "eu-central-1"
}

variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = "dev"
}

variable "description" {
  description = "A short description of the lambda function"
  type        = string
}

variable "filename" {
  description = "The name of the zipped folder containing the lambda code"
  type        = string
}

variable "function_name" {
  description = "The name of the lambda function"
  type        = string
  default     = "test_lambda_function"
}

variable "handler" {
  description = "The handler of the lambda function"
  type        = string
}

variable "lambda_layer_arn" {
  description = "A list of lambda layers to be attached to the lambda"
  type        = list(string)
}

variable "environment_variables" {
  description = "The environment variables for the lambda"
  default     = { "stage" : "dev" }
}

variable "source_code_path" {
  description = "The path to the source code of the lambda"
  type        = string
}

variable "output_path" {
  description = "The output_pathofo the bundled source code"
  type        = string
}

variable "runtime" {
  description = "The lambda runtime"
  type        = string
  default     = "python3.9"
}

variable "architectures" {
  description = "The list of architechtures the lambda can run on"
  type        = list(string)
  default     = ["arm64"]
}

variable "memory_size" {
  description = "The memory size allocated to the lambda"
  type        = number
  default     = 1028
}

variable "build_command" {
  description = "The command to run to create the Lambda package zip file"
  type        = string
  default     = "python build.py '$filename' '$source'"
}

variable "build_paths" {
  description = "The files or directories used by the build command, to trigger new Lambda package builds whenever build scripts change"
  type        = list(string)
  default     = ["build.py"]
}

variable "layer_name" {
  type        = string
  description = "A lambda layer"
  default     = "test-layer"
}

variable "deploy_layer" {
  type        = bool
  description = "A boolean to decide when to deploy a new version of the layer or not"
  default     = false
}

variable "lambda_policy_file" {
  type        = string
  description = "The full path of the json file containing the policy to be attached to a lambd"
}

variable "create_lambda_role" {
  type        = bool
  description = "A boolean to determine whether to create lambda role or not"
}

variable "cloudwatch_policy_file" {
  type = string
  description = "The full path to cloudwatch policy file"
}

variable "cloudwatch_path" {
  description = "Path in which to create the policy. See IAM Identifiers: https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html"
  type        = string
  default     = "/"
}