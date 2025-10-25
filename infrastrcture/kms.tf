data "aws_kms_alias" "existing" {
  name = "alias/eks/${var.eks_name}"
}

resource "aws_kms_key" "eks_key" {
  count = length(data.aws_kms_alias.existing.id) == 0 ? 1 : 0
  enable_key_rotation = true
  description         = var.eks_name
}