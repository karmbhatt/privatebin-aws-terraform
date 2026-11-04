terraform {
  required_version = ">= 1.10.0"

  backend "s3" {
    bucket       = "privatebin-tfstate-904869824787-1793773713"
    key          = "privatebin/terraform.tfstate"
    region       = "eu-north-1"
    encrypt      = true
    use_lockfile = true
    profile      = "privatebin-nagarro"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
