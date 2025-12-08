
# CONDITIONAL EXPRESSIONS

resource "aws_instance" "condistional_example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.environment == "prod" ? "t3.large" : "t3.micro"
    tags = {
        instance_type = var.environment 
    }
  
}

# Dynamic Blocks

resource "aws_security_group" "dynamic_example" {
  name        = "dynamic_example_sg"
  description = "Security group with dynamic ingress rules"
  
  dynamic "ingress" {
    for_each = { for idx, sg in var.security_groups : idx => sg }
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }
    tags = {
        Name = "dynamic_example_sg"
    }
}
   
# Splat Expressions


locals {
  all_instance_info = aws_instance.condistional_example[*].id
}
    
output "all_instance_ids" {
  value = local.all_instance_info
}