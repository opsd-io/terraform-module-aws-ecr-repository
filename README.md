<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/opsd-io/terraform-module-template/main/.github/img/opsd-github-repo-dark-mode.svg">
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/opsd-io/terraform-module-template/main/.github/img/opsd-github-repo-light-mode.svg">
  <img alt="OPSd - the unique and effortless way of managing cloud infrastructure." src="https://raw.githubusercontent.com/opsd-io/terraform-module-template/update-tools/.github/img/opsd-github-repo-light-mode.svg" width="400">
</picture>

Meet **OPSd**. The unique and effortless way of managing cloud infrastructure.

# terraform-module-aws-ecr-repository

## Introduction

This module provides an Elastic Container Registry Repository.

## Usage

```hcl
module "example" {
  source = "github.com/opsd-io/terraform-module-aws-ecr-repository"
  name   = "foobar-service"

  image_tag_mutable = true
  scan_on_push      = true
}
```

**IMPORTANT**: Make sure not to pin to master because there may be breaking changes between releases.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy_document.repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | A map of tags to assign to every resource in this module. | `map(string)` | `{}` | no |
| <a name="input_encryption_kms_key"></a> [encryption\_kms\_key](#input\_encryption\_kms\_key) | The ARN of the KMS key to use for the repository encryption. | `string` | `null` | no |
| <a name="input_image_tag_mutable"></a> [image\_tag\_mutable](#input\_image\_tag\_mutable) | The tag mutability setting for the repository. | `bool` | `true` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | List of lifecycle policy rules. | <pre>list(object({<br>    priority     = number<br>    description  = optional(string)<br>    tag_status   = string # "tagged"|"untagged"|"any"<br>    tag_patterns = optional(list(string))<br>    tag_prefixes = optional(list(string))<br>    count_type   = string # "imageCountMoreThan"|"sinceImagePushed"<br>    count_number = number<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the repository. | `string` | n/a | yes |
| <a name="input_policy_documents"></a> [policy\_documents](#input\_policy\_documents) | List of IAM policy documents that are merged together for the repository policy. | `list(string)` | `[]` | no |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Indicates whether images are scanned after being pushed to the repository. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Full ARN of the repository. |
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | The registry ID where the repository was created. |
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the repository. |
<!-- END_TF_DOCS -->

## Examples of usage

Do you want to see how the module works? See all the [usage examples](examples).

## Related modules

The list of related modules (if present).

## Contributing

If you are interested in contributing to the project, see see our [guide](https://github.com/opsd-io/contribution).

## Support

If you have a problem with the module or want to propose a new feature, you can report it via the project's (Github) issue tracker.

If you want to discuss something in person, you can join our community on [Slack](https://join.slack.com/t/opsd-community/signup).

## License

[Apache License 2.0](LICENSE)
