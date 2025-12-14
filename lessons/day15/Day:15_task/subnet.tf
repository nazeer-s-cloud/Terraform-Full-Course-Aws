# us-east-1 subnet
resource "aws_subnet" "use1_subnet" {
  provider                = aws.use1
  vpc_id                  = aws_vpc.use1.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "use1-public-subnet"
  }
}

# us-west-2 subnet
resource "aws_subnet" "usw2_subnet" {
  provider                = aws.usw2
  vpc_id                  = aws_vpc.usw2.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "usw2-public-subnet"
  }
}

# ap-south-1 subnet
resource "aws_subnet" "aps1_subnet" {
  provider                = aws.aps1
  vpc_id                  = aws_vpc.aps1.id
  cidr_block              = "10.2.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "aps1-public-subnet"
  }
}
