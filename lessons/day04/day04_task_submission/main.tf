

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

# backend configuration
terraform {
  backend "s3" {
    bucket         = "indica-terraform-state-06786"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = "true"
    encrypt        = true
  }
}   



