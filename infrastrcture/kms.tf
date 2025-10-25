resource "aws_kms_key" "eks_key" {
  enable_key_rotation = true
  description         = var.eks_name  # if you want to use eks_name here
}

resource "aws_kms_alias" "eks_alias" {
  name          = "alias/eks/${var.eks_name}"
  target_key_id = aws_kms_key.eks_key.key_id

  lifecycle {
    ignore_changes = [name]
  }
}