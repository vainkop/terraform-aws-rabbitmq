terraform {
  required_version = ">= 1.3"

  backend "s3" {}

  required_providers {
    aws    = "= 3.75.2"
    local  = "= 2.2.3"
    random = "= 3.4.3"
  }
}

provider "aws" {
  region = var.region
}
