resource "random_string" "name" {
  length  = 6
  special = false
  upper   = false
}

resource "null_resource" "install_python_dependencies" {
  provisioner "local-exec" {
    command = "pip3 install --upgrade -r ${var.filename}/requirements.txt -t ${var.filename}/"

    environment = {
      source_code_path = var.source_code_path
      path_cwd         = path.cwd
      path_module      = path.module
      random_string    = random_string.name.result
    }
  }

  triggers = {
    dependencies_versions = sha1(join("", [for f in fileset("${var.filename}", "*") : filesha1("${var.filename}/${f}")]))
    source_versions       = sha1(join("", [for f in fileset("${var.filename}", "*") : filesha1("${var.filename}/${f}")]))
  }
}

resource "random_uuid" "lambda_src_hash" {
  keepers = {
    for filename in setunion(
      fileset(var.filename, "/"),
      fileset(var.filename, "requirements.txt")
    ) :
    filename => filemd5("${var.filename}/${filename}")
  }
}

data "archive_file" "lambda_source" {
  depends_on = [null_resource.install_python_dependencies]
  excludes = [
    "__pycache__",
    "venv",
  ]

  source_dir = var.filename
  output_path = var.output_path
  type        = "zip"
}