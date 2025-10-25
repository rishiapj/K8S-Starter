resource "aws_kms_alias" "eks_alias" {
  name          = "alias/eks/${var.eks_cluster_name}"
  target_key_id = aws_kms_key.eks_key.key_id

  lifecycle {
    ignore_changes = [name]
  }
}