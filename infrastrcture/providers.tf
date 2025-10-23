terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

backend "s3" {
    bucket         = "rishi-terraform-bucket-985809756777"
    key            = "rishi/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table" # optional for state locking
  }
