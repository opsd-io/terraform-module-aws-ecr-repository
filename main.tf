terraform {
  required_version = ">= 1.5.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

resource "aws_ecr_repository" "main" {
  name                 = var.name
  force_delete         = false
  image_tag_mutability = var.image_tag_mutable ? "MUTABLE" : "IMMUTABLE"

  encryption_configuration {
    encryption_type = var.encryption_kms_key != null ? "KMS" : "AES256"
    kms_key         = var.encryption_kms_key
  }

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }

  tags = merge(var.common_tags, {
    Name = var.name
  })

}

data "aws_iam_policy_document" "repository_policy" {
  override_policy_documents = var.policy_documents
}

resource "aws_ecr_repository_policy" "main" {
  count      = length(var.policy_documents) > 0 ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy     = data.aws_iam_policy_document.repository_policy.json
}

# https://docs.aws.amazon.com/AmazonECR/latest/userguide/LifecyclePolicies.html

resource "aws_ecr_lifecycle_policy" "main" {
  count      = length(var.lifecycle_rules) > 0 ? 1 : 0
  repository = aws_ecr_repository.main.name
  policy = jsonencode({
    rules = [
      for rule in var.lifecycle_rules : {
        for key, val in {
          rulePriority = rule.priority
          description  = rule.description
          selection = {
            for key, val in {
              tagStatus      = rule.tag_status
              tagPatternList = rule.tag_status == "tagged" ? rule.tag_patterns : null
              tagPrefixList  = rule.tag_status == "tagged" ? rule.tag_prefixes : null
              countType      = rule.count_type
              countUnit      = rule.count_type == "sinceImagePushed" ? "days" : null
              countNumber    = rule.count_number
            } : key => val if val != null
          }
          action = {
            type = "expire"
          }
        } : key => val if val != null
      }
    ]
  })
}
