variable "lambda_layer_arn" {
  type        = list(string)
  description = "List of valid lambda layer ARNs"
  default     = [""]
}

variable "environment_variables" {
  type        = map(any)
  default     = { "foo" : "bar" }
  description = "a dictionary of environment variables for the resource"
}

variable "region" {
  type        = string
  description = "The aws reegion"
  default     = "eu-central-1"
}

variable "environment_name" {
  type        = string
  description = "The name of the environment. Should be either dev or prod"
  default     = "dev"
}