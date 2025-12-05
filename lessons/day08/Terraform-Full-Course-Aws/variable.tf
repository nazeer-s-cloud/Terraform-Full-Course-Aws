# For COUNT
variable "s3_bucket_names" {
  type = list(string)
  default = [
    "day08-count-bucket-1-2025",
    "day08-count-bucket-2-2025"
  ]
}

# For FOR_EACH
variable "s3_bucket_set" {
  type = set(string)
  default = [
    "day08-each-bucket-a-2025",
    "day08-each-bucket-b-2025"
  ]
}

variable "environment" {
  type    = string
  default = "dev"
}
