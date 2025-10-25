resource "aws_kms_key" "eks_key" {
  description             = "KMS key for EKS cluster encryption"
  deletion_window_in_days = 30
  enable_key_rotation     = trueeks_name
}

resource "aws_kms_alias" "eks_alias" {
  name          = "alias/eks/${var.eks_name}"
  target_key_id = aws_kms_key.eks_key.key_id

  lifecycle {
    ignore_changes = [name]
  }
}