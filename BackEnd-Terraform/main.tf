    provider "aws" {
      region = "us-east-1" # Replace with your desired region
    }

    resource "aws_s3_bucket" "s3_bucket" {
      bucket = "terraform-state-bucket-name" # Choose a globally unique name
      acl    = "private"

      versioning {
        enabled = true # Recommended for state file versioning
      }

      server_side_encryption_configuration {
        rule {
          apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
          }
        }
      }

      tags = {
        Name        = "Terraform State Bucket"
        Environment = "Dev"
      }
    }

    resource "aws_dynamodb_table" "terraform_state_lock" {
      name         = "terraform-state-lock-table" # Choose a unique name
      billing_mode = "PAY_PER_REQUEST"
      hash_key     = "LockID"

      attribute {
        name = "LockID"
        type = "S"
      }

      tags = {
        Name        = "Terraform State Lock Table"
        Environment = "Dev"
      }
    }