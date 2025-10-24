module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster-eks"
  kubernetes_version = "1.33"

  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true

  create_cloudwatch_log_group = false

  vpc_id                   = aws_vpc.main.id
  subnet_ids               = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]
  control_plane_subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id]

  # Add managed node group
  managed_node_groups = {
    general-purpose = {
      desired_capacity = 2
      min_capacity     = 1
      max_capacity     = 3

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"

      labels = {
        role = "general"
      }

      tags = {
        Name = "eks-node-group"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}