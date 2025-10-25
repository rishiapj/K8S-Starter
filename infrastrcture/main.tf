module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = "1.30"

  enable_irsa = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  tags = {
    cluster = "my-aws-eks-cluster"
  }

  
cluster_encryption_config = {
    resources        = ["secrets"]
    provider_key_arn = var.existing_kms_key_arn != "" ? var.existing_kms_key_arn : aws_kms_key.eks_key[0].arn
  }


  # EKS Managed Node Group(s)
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