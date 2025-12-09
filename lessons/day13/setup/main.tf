data "aws_vpc" "shared-network-vpc" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}

data "aws_subnet" "shared-primary-subnet" {
  vpc_id = data.aws_vpc.shared-network-vpc.id

  filter {
    name   = "tag:Name"
    values = ["shared-primary-subnet"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared-network-vpc.id]
  }
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  subnet_id = data.aws_subnet.shared-primary-subnet.id

  tags = {
    Name = "day013-instance"
  }
}

