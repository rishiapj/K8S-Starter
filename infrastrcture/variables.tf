variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "eks_name" {
  description = "AWS EKS Cluster name"
  type        = string
}

variable "sg_name" {
  description = "Security group name"
  default     = "aws-eks-sg"
}