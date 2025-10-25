# Detect existing alias
data "aws_kms_alias" "existing" {
  name = "alias/eks/${var.eks_name}"
}

# Create KMS key only if alias does not exist
resource "aws_kms_key" "eks_key" {
  count               = length(data.aws_kms_alias.existing.id) == 0 ? 1 : 0
  enable_key_rotation = true
  description         = var.eks_name
}

# Use existing alias ARN if found, else new key ARN
locals {
  kms_key_arn = length(data.aws_kms_alias.existing.id) > 0 ? data.aws_kms_alias.existing.target_key_id : aws_kms_key.eks_key[0].arn
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = "1.30"
  enable_irsa     = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = local.kms_key_arn
  }

  eks_managed_node_group_defaults = {
    ami_type               = "AL2_x86_64"
    instance_types         = ["t2.micro"]
    vpc_security_group_ids = [aws_security_group.eks-sg.id]
  }

  eks_managed_node_groups = {
    node_group = {
      min_size     = 2
      max_size     = 3
      desired_size = 2
    }
  }
}