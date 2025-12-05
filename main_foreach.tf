resource "aws_s3_bucket" "example_each" {
  for_each = var.s3_bucket_set

  bucket = each.value

  tags = {
    Name        = each.value
    Environment = var.environment
    Type        = "foreach-example"
    ManagedBy   = "terraform"
  }
}
