    provider "aws" {
      region = "us-east-1" # Replace with your desired region
    }

    resource "aws_s3_bucket" "s3_bucket" {
      bucket = "rishi-terraform-bucket-985809756777" # Choose a globally unique name
      key            = "rishi/terraform.tfstate"
      region         = "us-east-1"
      encrypt        = true
      dynamodb_table = "terraform-lock"
      tags = {
        Name        = "Terraform State Bucket"
        Environment = "Dev"
      }
    }

    