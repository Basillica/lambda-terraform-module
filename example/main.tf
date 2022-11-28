terraform {
  backend "s3" {
    profile = "" # the name of the backend
    bucket  = "" # bucket name
    key     = "lambda/terraform.tfstate"
    region  = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "eu-central-1"
  profile = ""
}


module "agri_lambda" {
  source = "git@github.com:Basillica/lambda-terraform-module.git"
  # Input Variables
  filename              = "lambda-code"
  function_name         = "example_lambda_function"
  handler               = "main.handler"
  description           = "A test lambda function"
  lambda_layer_arn      = ["arn:aws:lambda:eu-central-1:770693421928:layer:Klayers-p38-Pillow:4"] # adding a sample pillow layer
  environment_variables = var.environment_variables != { "foo" : "bar" } ? var.environment_variables : {}
  region                = var.region
  environment_name      = var.environment_name
  source_code_path      = "${path.cwd}/lambda-code"
  output_path           = "sample.zip"

  lambda_policy_file     = "policies/lambda_policy.json"
  create_lambda_role     = true
  cloudwatch_policy_file = "policies/lambda_cloudwatch.json"
}