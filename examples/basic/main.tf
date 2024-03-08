resource "random_pet" "repository_name" {
  length = 3
}

module "example" {
  source = "github.com/opsd-io/terraform-module-aws-ecr-repository"

  name              = random_pet.repository_name.id
  image_tag_mutable = true
  scan_on_push      = true
}
