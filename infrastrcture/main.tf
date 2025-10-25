# Detect existing KMS alias
data "aws_kms_alias" "existing" {
  name = "alias/eks/${var.eks_name}"
}

# Create KMS key only if alias does not exist
resource "aws_kms_key" "eks_key" {
  count               = length(data.aws_kms_alias.existing.*.id) == 0 ? 1 : 0
  enable_key_rotation = true
  description         = var.eks_name
}

# Create alias only if new key is created
resource "aws_kms_alias" "eks_alias" {
  count        = length(data.aws_kms_alias.existing.*.id) == 0 ? 1 : 0
  name         = "alias/eks/${var.eks_name}"
  target_key_id = aws_kms_key.eks_key[0].key_id
}

# Local to determine which ARN to use
locals {
  kms_key_arn = try(data.aws_kms_alias.existing.target_key_id, aws_kms_key.eks_key[0].arn)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = "1.30"
  enable_irsa     = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    cluster = var.eks_name
  }

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