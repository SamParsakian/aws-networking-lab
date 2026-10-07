# Credentials are not set here. The AWS CLI login session is used.
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "sam-aws-networking-lab"
      ManagedBy   = "Terraform"
      Environment = "Lab"
    }
  }
}
