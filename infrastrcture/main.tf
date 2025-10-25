module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_name
  cluster_version = "1.30"
  enable_irsa     = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

 
  cluster_endpoint_public_access  = true


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

  
 # ✅ Add IAM role mapping here
  
resource "aws_eks_access_entry" "pipeline_role_access" {
  cluster_name  = module.eks.cluster_name
  principal_arn = var.pipeline_role_arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "pipeline_role_policy" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.pipeline_role_access.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  access_scope {
    type = "cluster"
  }
}


}