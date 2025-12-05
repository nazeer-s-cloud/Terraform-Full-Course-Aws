# create_before_destroy

resource "aws_s3_bucket" "demo" {
    bucket = "day09-lifecycle-${var.environment}-2025"

    lifecycle {
      create_before_destroy = true
    }

    tags = {
      name = "demo tag"
      environment = var.environment
    }
}


# prevent_destroy

resource "aws_s3_bucket" "demo_prevent_destroy" {
    bucket = "day09-prevent-destroy-${var.environment}-2025"

    lifecycle {
      prevent_destroy = true
    }

    tags = {
      name = "prevent destroy tag"
      environment = var.environment
    }
  
}

# ignore_changes

resource "aws_s3_bucket" "demo_ignore_changes" {
    bucket = "day09-ignore-changes-${var.environment}-2025"

    lifecycle {
      ignore_changes = [
        tags["LastModified"]
      ]
    }

    tags = {
      name = "ignore changes tag"
      environment = var.environment
      LastModified = "2025-10-17"
    }
}

# replace_triggered_by

resource "aws_s3_bucket" "trigger_source" {
  bucket = "day09-trigger-source-${var.environment}-2025"
}

resource "aws_s3_bucket" "triggered_bucket" {
  bucket = "day09-triggered-${var.environment}-2025"

  lifecycle {
    replace_triggered_by = [
      aws_s3_bucket.trigger_source.id
    ]
  }
}



  
    