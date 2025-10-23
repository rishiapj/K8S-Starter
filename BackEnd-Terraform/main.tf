    provider "aws" {
      region = "us-east-1" # Replace with your desired region
    }

    resource "aws_s3_bucket" "s3_bucket" {
      bucket = "rishi-terraform-bucket" # Choose a globally unique name

      tags = {
        Name        = "Terraform State Bucket"
        Environment = "Dev"
      }
    }

    