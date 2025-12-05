resource "aws_s3_bucket" "s3_bucket_names" {
    bucket = "day09-${var.environment.var}-2025"

    tags = {
      name =  "sample bucket"
      ManagedBy = "Terraform "
      environment = var.environment
    }
  
}

