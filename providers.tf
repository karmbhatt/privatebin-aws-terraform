provider "aws" {
  region  = "eu-north-1"
  profile = "privatebin-nagarro"

  default_tags {
    tags = {
      Project     = "privatebin-terraform"
      Environment = "assignment"
      ManagedBy   = "Terraform"
    }
  }
}

# Provider without default tags, used only where tagging
# permissions are restricted.
provider "aws" {
  alias   = "untagged"
  region  = "eu-north-1"
  profile = "privatebin-nagarro"
}
