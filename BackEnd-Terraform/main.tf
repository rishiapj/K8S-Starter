provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "rishi-terraform-bucket-985809756777"
  force_destroy = true

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "bootstrap"
  }
}