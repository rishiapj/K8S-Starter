terraform {
  required_version = "~> 1.9.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  backend "s3" {
    bucket         = "dev-rishi-tf-bucket"
    region         = "us-east-1"
    key            = "eks/terraform.tfstate"
    use_loc_files = true
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws-region
}