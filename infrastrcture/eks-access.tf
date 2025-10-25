# IAM Role for Azure Pipeline
resource "aws_iam_role" "pipeline_role" {
  name = "azure-pipeline-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::985809756777:user/rishikesh"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach EKS policies to the role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_worker_policy" {
  role       = aws_iam_role.pipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Access Entry for EKS cluster
resource "aws_eks_access_entry" "pipeline_role_access" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_iam_role.pipeline_role.arn
  type          = "STANDARD"
}

# Associate admin policy for cluster access
resource "aws_eks_access_policy_association" "pipeline_role_policy" {
  cluster_name  = module.eks.cluster_name
  principal_arn = aws_eks_access_entry.pipeline_role_access.principal_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  access_scope {
    type = "cluster"
  }
}


