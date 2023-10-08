terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.20.0"
    }
  }
  required_version = "~> 1.5"
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}
