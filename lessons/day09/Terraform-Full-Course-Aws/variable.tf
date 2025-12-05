variable "environment" {
    description = "The environment for deployment (e.g., dev, staging, prod)"
    type        = string
    default     = "dev"
  
}

variable "allowed_region" {
    description = "The AWS region where resources are allowed to be created"
    type        = list(string)
    default     = ["us-east-1", "us-west-2", "eu-west-1"] 
  
}

