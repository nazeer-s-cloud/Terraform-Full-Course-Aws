# ==============================================================================

# EC2 Instance - Demonstrating all type constraints
resource "aws_instance" "web_server" {
  # String type: AMI ID and instance type
  ami           = "ami-0e8459476fed2e23b"
  instance_type = var.allowed_vm_types[1]
  
  # Number type: Instance count
  count = var.instance_count
  
  
  # Set type: Availability zone (using first element from set)
  availability_zone = var.region  # Need to convert to list to access the indices
  
  # List type: Security group
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  
  # Object type: Using server config object attributes
  # Note: This demonstrates object access syntax
  # instance_type could also be: var.server_config.instance_type
  # monitoring could also be: var.server_config.monitoring
  
  # Map type: Tags

  
}

# Security Group for EC2
resource "aws_security_group" "web_sg" {
  # String type: Name and description
  name        = "${var.server_config.name}-sg"  # Object type usage
  description = "Security group for web server"
  
  # HTTP access using tuple type (port number from network_config[2])
  ingress {
    from_port   = var.network_config[2]  # Tuple type: third element (number)
    to_port     = var.network_config[2]  # Tuple type: third element (number)
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  # SSH access  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks  # List type
  }
  
  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
}

