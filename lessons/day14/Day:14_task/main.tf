resource "aws_s3_bucket" "site_bucket" {
  bucket = var.domain_name

  tags = {
    Name = var.domain_name
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "oac-${var.domain_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.site_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.site_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.cloudflare.arn
          }
        }
      }
    ]
  })
}

resource "aws_s3_object" "website_files" {
  for_each = fileset("${path.module}/www", "*")

  bucket = aws_s3_bucket.site_bucket.id
  key    = each.value
  source = "${path.module}/www/${each.value}"

  content_type = lookup({
    html = "text/html",
    css  = "text/css",
    js   = "application/javascript"
  }, split(".", each.value)[1], "application/octet-stream")
}

resource "aws_cloudfront_distribution" "cloudflare" {
  enabled = true

  origin {
    domain_name              = aws_s3_bucket.site_bucket.bucket_regional_domain_name
    origin_id                = "s3Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id       = "s3Origin"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]

    forwarded_values {
      cookies {
        forward = "none"
      }
      query_string = false
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {

    acm_certificate_arn = "arn:aws:acm:us-east-1:084375544179:certificate/fef2b5dd-595c-4e8d-b7e9-242dd3a4d856"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}


























