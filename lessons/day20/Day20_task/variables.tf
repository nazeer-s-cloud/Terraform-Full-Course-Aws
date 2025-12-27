variable "project_name" {
    description = "The name of the project"
    type        = string
    default     = "MyTerraformProject"
  
}

variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "ap-south-1"
  
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "day20-eks"
}

variable "kubernetes_version" {
  description = "Kubernetes version to use for the EKS cluster"
  type        = string
  default     = "1.31"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "development"
}

variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  }

variable "public_subnet_cidrs" {
    description = "The CIDR block for the public subnet"
    type        = list(string)
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  }

variable "private_subnet_cidrs" {
    description = "The CIDR block for the private subnet"
    type        = list(string)
    default     = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  }


variable "availability_zones" {
  description = "List of availability zones to use"
  type        = list(string)
  default     = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]
}