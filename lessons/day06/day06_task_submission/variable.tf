variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
  default     = "day05-ec2"
}

variable "instance_type" {
  description = "EC2 machine type"
  type        = string
  default     = "t2.micro"
}

variable "ssh_key_name" {
  description = "task01"
  type        = string
}
