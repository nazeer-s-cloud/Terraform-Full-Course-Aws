############################
# Task 1: String Variables
############################
variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment prefix"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region for provider"

  validation {
    condition     = contains(var.allowed_region, var.region)
    error_message = "Region is not allowed!"
  }
}

############################
# Task 2: Number Variable
############################
variable "instance_count" {
  type        = number
  default     = 2
  description = "Number of instances to create"
}

############################
# Task 3: Boolean Variables
############################
variable "monitoring_enabled" {
  type    = bool
  default = true
}

variable "associate_public_ip" {
  type    = bool
  default = true
}

############################
# Task 4: List(String)
############################
variable "cidr_block" {
  type = list(string)
  default = [
    "10.0.0.0/8",
    "192.168.0.0/16",
    "172.16.0.0/12"
  ]
}

############################
# Task 5: Allowed VM Types
############################
variable "allowed_vm_types" {
  type = list(string)
  default = ["t2.micro", "t2.small", "t3.micro", "t3.small"]
}

variable "instance_type" {
  type = string
  default = "t2.micro"

  validation {
    condition     = contains(var.allowed_vm_types, var.instance_type)
    error_message = "Instance type not allowed."
  }
}

############################
# Task 6: Set(String)
############################
variable "allowed_region" {
  type = set(string)
  default = ["us-east-1", "us-west-2", "eu-west-1"]
}

############################
# Task 7: Map(String)
############################
variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Name        = "dev-instance"
    created_by  = "terraform"
  }
}

############################
# Task 8: Tuple
############################
variable "ingress_values" {
  type    = tuple([number, string, number])
  default = [443, "tcp", 443]
}

############################
# Task 9: Object Constraint
############################
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
