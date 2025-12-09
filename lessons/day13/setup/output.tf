output "aws_vpc" {
    value = data.aws_vpc.shared-network-vpc.id
}

output "aws_instance_ami" {
    value = data.aws_ami.amazon_linux_2.id
  
}

output "aws_subnet" {
    value = data.aws_subnet.shared-primary-subnet.id
  
}


