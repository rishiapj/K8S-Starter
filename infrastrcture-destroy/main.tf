terraform {
  required_version = ">= 1.3.0"

  backend "s3" {
    bucket         = "rishi-terraform-bucket-985809756777"
    key            = "rishi/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Use the latest stable version
    }
  }
}

provider "aws" {
  region = "us-east-1"
}