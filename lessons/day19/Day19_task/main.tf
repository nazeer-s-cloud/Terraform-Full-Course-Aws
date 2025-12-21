resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS/HTTP/SSH inbound; all outbound"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "demo" {
  ami                   = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type         = "t2.micro"
  key_name              = "task01"
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  provisioner "file"{
    source     =  "scripts/welcome.sh"
    destination = "/tmp/welcome.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/welcome.sh",
      "sudo /tmp/welcome.sh"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/home/niz/Downloads/task01.pem")
      host        = self.public_ip
    }
  }

  provisioner "remote-exec" {
  when = destroy

  inline = [
    "echo 'Cleaning up files on EC2 before destroy'",
    "sudo rm -f /tmp/welcome.sh /tmp/welcome_msg.txt",
    "echo 'Cleanup completed on EC2'"
  ]
}

  tags = {
    Name = "HelloWorld"
  }

  

}