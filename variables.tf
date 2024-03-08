variable "common_tags" {
  description = "A map of tags to assign to every resource in this module."
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Name of the repository."
  type        = string
}

variable "image_tag_mutable" {
  description = "The tag mutability setting for the repository."
  type        = bool
  default     = true
}

variable "scan_on_push" {
  description = "Indicates whether images are scanned after being pushed to the repository."
  type        = bool
  default     = true
}

variable "encryption_kms_key" {
  description = "The ARN of the KMS key to use for the repository encryption."
  type        = string
  default     = null
}


variable "policy_documents" {
  description = "List of IAM policy documents that are merged together for the repository policy."
  type        = list(string)
  default     = []
}


variable "lifecycle_rules" {
  description = "List of lifecycle policy rules."
  type = list(object({
    priority     = number
    description  = optional(string)
    tag_status   = string # "tagged"|"untagged"|"any"
    tag_patterns = optional(list(string))
    tag_prefixes = optional(list(string))
    count_type   = string # "imageCountMoreThan"|"sinceImagePushed"
    count_number = number
  }))
  default = []
}
