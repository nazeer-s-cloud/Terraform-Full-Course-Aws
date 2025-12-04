output "resource_name" {
  value       = var.tags["Name"]
  description = "Name tag extracted from tags map"
}

output "deployment_summary" {
  value = {
    environment    = var.environment
    instance_count = var.instance_count
    name_tag       = var.tags["Name"]
  }
}
