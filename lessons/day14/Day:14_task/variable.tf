variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  type        = string
  default     = "nazeercloud.online"
}
