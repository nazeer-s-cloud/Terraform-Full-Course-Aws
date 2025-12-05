#precondition example
resource "aws_s3_bucket" "validated_region_bucket" {
  bucket = "day09-validated-region-${var.environment}-2025"

  lifecycle {
    precondition {
      condition     = contains(var.allowed_region, data.aws_region.current.name)
      error_message = "ERROR: Region ${data.aws_region.current.name} is not allowed!"
    }
  }

  tags = {
    Name = "Precondition Example"
    Env  = var.environment
  }
}

data "aws_region" "current" {}

#postcondition example

resource "aws_s3_bucket" "post_condition_bucket" {
  bucket = "day09-postcondition-${var.environment}-2025"

  tags = {
    Environment = "production"
    Compliance  = "SOC2"
  }

  lifecycle {
    postcondition {
      condition     = contains(keys(self.tags), "Compliance")
      error_message = "Bucket must include a Compliance tag!"
    }

    postcondition {
      condition     = contains(keys(self.tags), "Environment")
      error_message = "Environment tag missing!"
    }
  }
}
