provider "aws" {
  region  = "eu-north-1"
  profile = "privatebin-nagarro"

  default_tags {
    tags = {
      Project   = "privatebin-terraform"
      ManagedBy = "Terraform"
      Purpose   = "Terraform-State"
    }
  }
}
