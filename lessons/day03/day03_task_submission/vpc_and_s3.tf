resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "niz-330123-example-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}