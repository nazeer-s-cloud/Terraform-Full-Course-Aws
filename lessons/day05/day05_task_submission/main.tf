resource "aws_instance" "day05" {
  ami                    = "ami-0ecb62995f68bb549" 
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name

  tags = merge(
    {
      Name = var.instance_name
    },
    local.common_tags
  )
}
