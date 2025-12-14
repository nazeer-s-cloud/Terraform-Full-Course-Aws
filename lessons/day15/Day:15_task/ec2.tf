# AMI Data (Amazon Linux 2)

data "aws_ami" "amazon_linux_use1" {
  provider    = aws.use1
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "amazon_linux_usw2" {
  provider    = aws.usw2
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "amazon_linux_aps1" {
  provider    = aws.aps1
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# EC2 Instances (Apache installed)

resource "aws_instance" "use1_ec2" {
  provider = aws.use1
  ami      = data.aws_ami.amazon_linux_use1.id

  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.use1_subnet.id
  vpc_security_group_ids = [aws_security_group.use1_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>us-east-1 VPC</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "use1-ec2" }
}

resource "aws_instance" "usw2_ec2" {
  provider = aws.usw2
  ami      = data.aws_ami.amazon_linux_usw2.id

  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.usw2_subnet.id
  vpc_security_group_ids = [aws_security_group.usw2_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>us-west-2 VPC</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "usw2-ec2" }
}

resource "aws_instance" "aps1_ec2" {
  provider = aws.aps1
  ami      = data.aws_ami.amazon_linux_aps1.id

  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.aps1_subnet.id
  vpc_security_group_ids = [aws_security_group.aps1_sg.id]
  key_name               = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>ap-south-1 VPC</h1>" > /var/www/html/index.html
              EOF

  tags = { Name = "aps1-ec2" }
}
