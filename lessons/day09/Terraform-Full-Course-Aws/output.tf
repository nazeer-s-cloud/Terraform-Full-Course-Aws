output "all_bucket_names" {
  value = [
    aws_s3_bucket.basic.bucket,
    aws_s3_bucket.create_before_destroy_bucket.bucket,
    aws_s3_bucket.protected_bucket.bucket,
    aws_s3_bucket.ignored_bucket.bucket,
    aws_s3_bucket.trigger_source.bucket,
    aws_s3_bucket.triggered_bucket.bucket,
    aws_s3_bucket.validated_region_bucket.bucket,
    aws_s3_bucket.post_condition_bucket.bucket
  ]
}
