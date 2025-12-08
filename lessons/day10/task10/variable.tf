variable "environment" {
  description = "Environment name (dev or prod)"
  type        = string
  default     = "dev"
}


# Dynamic Blocks

variable "security_groups" {
    description = "example for Dynamic block"
    type = list(object({
        from_port    = number
        to_port      = number
        protocol = string
        cidr_blocks    = list(string)
        description = string
    }))
    default = [
        {
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            description = "SSH access"
        },
        {
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
            description = "HTTP access"
        }
    
    ]

}


