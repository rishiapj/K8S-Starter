
variable "existing_kms_key_arn" {
  type        = string
  default     = ""
  description = "Provide an existing KMS key ARN if available. Leave empty to create a new one."
}

# Create KMS key only if no existing ARN is provided
resource "aws_kms_key" "eks_key" {
  count               = var.existing_kms_key_arn == "" ? 1 : 0
  enable_key_rotation = true
  description         = var.eks_name
}

resource "aws_kms_alias" "eks_alias" {
  count        = var.existing_kms_key_arn == "" ? 1 : 0
  name         = "alias/eks/${var.eks_name}"
  target_key_id = aws_kms_key.eks_key[0].key_id
}
