variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
  
}

variable "public_subnet_cidrs" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
  
}

variable "private_subnet_cidrs" {
    description = "The CIDR block for the private subnet"
    type        = list(string)
  
}

variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
}

variable "project_name" {
    description = "The name of the project"
    type        = string
  
}