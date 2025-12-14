resource "aws_vpc" "use1" {
  provider   = aws.use1
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "vpc-use1"
  }
}

resource "aws_vpc" "usw2" {
  provider   = aws.usw2
  cidr_block = "10.1.0.0/16"

  tags = {
    Name = "vpc-usw2"
  }
}

resource "aws_vpc" "aps1" {
  provider   = aws.aps1
  cidr_block = "10.2.0.0/16"

  tags = {
    Name = "vpc-aps1"
  }
}
