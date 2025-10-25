variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_name" {
  description = "VPC name"
  type        = string
  default     = "my-aws-eks-vpc"

}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "eks_name" {
  description = "AWS EKS Cluster name"
  type        = string  
  default     = "my-aws-eks-cluster"

}

variable "sg_name" {
  description = "Security group name"
  default     = "my-aws-eks-sg"
}



variable "pipeline_role_arn" {
  description = "IAM Role ARN for Azure Pipeline"
  type        = string
}
