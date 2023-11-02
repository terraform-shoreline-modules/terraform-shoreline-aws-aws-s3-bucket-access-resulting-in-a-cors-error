resource "shoreline_notebook" "cors_error_while_accessing_s3_bucket" {
  name       = "cors_error_while_accessing_s3_bucket"
  data       = file("${path.module}/data/cors_error_while_accessing_s3_bucket.json")
  depends_on = [shoreline_action.invoke_s3_update_cors_config]
}

resource "shoreline_file" "s3_update_cors_config" {
  name             = "s3_update_cors_config"
  input_file       = "${path.module}/data/s3_update_cors_config.sh"
  md5              = filemd5("${path.module}/data/s3_update_cors_config.sh")
  description      = "Update the CORS configuration to match the expected values.Verify that the CORS configuration is properly set on the bucket."
  destination_path = "/tmp/s3_update_cors_config.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_s3_update_cors_config" {
  name        = "invoke_s3_update_cors_config"
  description = "Update the CORS configuration to match the expected values.Verify that the CORS configuration is properly set on the bucket."
  command     = "`chmod +x /tmp/s3_update_cors_config.sh && /tmp/s3_update_cors_config.sh`"
  params      = ["BUCKET_NAME"]
  file_deps   = ["s3_update_cors_config"]
  enabled     = true
  depends_on  = [shoreline_file.s3_update_cors_config]
}

