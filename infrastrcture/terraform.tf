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
      version = "~> 5.95.0" # or ~> 6.17.0 if modules support v6
    }
  }
}