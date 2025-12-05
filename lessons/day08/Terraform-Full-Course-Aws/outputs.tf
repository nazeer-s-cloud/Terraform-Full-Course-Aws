# Output bucket names with FOR loop
output "count_bucket_names" {
  value = [for name in var.s3_bucket_names : name]
}

# Output IDs from FOR_EACH created buckets
output "foreach_bucket_ids" {
  value = { for k, v in aws_s3_bucket.example_each : k => v.id }
}
