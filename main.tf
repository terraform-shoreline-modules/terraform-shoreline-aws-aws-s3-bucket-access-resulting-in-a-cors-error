terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "cors_error_while_accessing_s3_bucket" {
  source    = "./modules/cors_error_while_accessing_s3_bucket"

  providers = {
    shoreline = shoreline
  }
}