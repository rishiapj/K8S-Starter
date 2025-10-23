provider "aws" {
  region = "us-east-1"
}



resource "aws_s3_bucket" "s3_bucket" {
  bucket = "rishi-terraform-bucket-985809756777" # change this
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

    

    