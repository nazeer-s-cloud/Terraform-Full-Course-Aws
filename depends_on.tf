resource "aws_s3_bucket" "primary" {
  bucket = "day08-primary-${var.environment}-2025"

  tags = {
    Name        = "Primary Bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket" "dependent" {
  bucket = "day08-dependent-${var.environment}-2025"

  depends_on = [aws_s3_bucket.primary]

  tags = {
    Name        = "Dependent Bucket"
    Environment = var.environment
    DependsOn   = "primary"
  }
}
