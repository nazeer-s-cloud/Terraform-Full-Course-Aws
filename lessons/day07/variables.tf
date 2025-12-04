# String Variables
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment name"
}

variable "region" {
  type        = string
  default     = "us-east-1"
}

# Number Variable
variable "instance_count" {
  type        = number
  default     = 1
}

# Bool Variables
variable "monitoring_enabled" {
  type        = bool
  default     = true
}

variable "associate_public_ip" {
  type        = bool
  default     = true
}

# List (string)
variable "cidr_block" {
  type    = list(string)
  default = ["10.0.0.0/8", "192.168.0.0/16", "172.16.0.0/12"]
}

# Allowed instance types - list(string)
variable "allowed_vm_types" {
  type    = list(string)
  default = ["t2.micro", "t2.small", "t3.micro", "t3.small"]
}

# Set(string)
variable "allowed_region" {
  type    = set(string)
  default = ["us-east-1", "us-west-2", "eu-west-1"]
}

# Map(string)
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Name        = "dev-Instance"
    created_by  = "terraform"
  }
}

# Tuple
variable "ingress_values" {
  type    = tuple([number, string, number])
  default = [443, "tcp", 443]
}

# Object
variable "config" {
  type = object({
    region         = string
    monitoring     = bool
    instance_count = number
  })

  default = {
    region         = "us-east-1"
    monitoring     = true
    instance_count = 1
  }
  
}

# Add your variable declarations here

variable "network_config" {
  description = "Tuple containing VPC CIDR, subnet CIDR base, and subnet mask"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed for ingress traffic"
  default     = ["0.0.0.0/0"]
}