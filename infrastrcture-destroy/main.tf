
terraform {
  backend "s3" {
    bucket         = "rishi-terraform-bucket-985809756777"
    key            = "rishi/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table" # optional for state locking
  }
}
