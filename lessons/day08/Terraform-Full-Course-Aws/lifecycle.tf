resource "aws_s3_bucket" "lifecycle_example" {
  bucket = "day08-lifecycle-${var.environment}-2025"

  lifecycle {
    prevent_destroy = false
    create_before_destroy = true
    ignore_changes = [
      tags["CreatedDate"]
    ]
  }

  tags = {
    Name        = "Lifecycle Example"
    Environment = var.environment
    CreatedDate = "2025-10-17"
  }
}
