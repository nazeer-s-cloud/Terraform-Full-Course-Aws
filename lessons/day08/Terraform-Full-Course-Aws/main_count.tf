resource "aws_s3_bucket" "example_count" {
  count = length(var.s3_bucket_names)

  bucket = var.s3_bucket_names[count.index]

  tags = {
    Name        = var.s3_bucket_names[count.index]
    Environment = var.environment
    Index       = count.index
    ManagedBy   = "terraform"
  }
}
