# String Example
output "environment_info" {
  value = {
    environment = var.environment
    region      = var.region
  }
}

# Number Example
output "instance_count_info" {
  value = {
    count = var.instance_count
  }
}

# Bool Example
output "bool_settings" {
  value = {
    monitoring          = var.monitoring_enabled
    associate_public_ip = var.associate_public_ip
  }
}

# List Example
output "cidr_blocks" {
  value = {
    vpc_cidr    = var.cidr_block[0]
    subnet_1    = var.cidr_block[1]
    subnet_2    = var.cidr_block[2]
    cidr_count  = length(var.cidr_block)
  }
}

# Allowed VM Types + Validation
output "allowed_vm_types_output" {
  value = {
    allowed_types = var.allowed_vm_types
    selected      = var.allowed_vm_types[0]
  }
}

# Set Example
output "allowed_region_output" {
  value = {
    allowed_regions = var.allowed_region
    is_valid_region = contains(var.allowed_region, var.region)
  }
}

# Map Example
output "tags_output" {
  value = {
    tags       = var.tags
    name_tag   = var.tags["Name"]
    all_keys   = keys(var.tags)
    all_values = values(var.tags)
  }
}

# Tuple Example (SG rule)
output "ingress_rule_info" {
  value = {
    from_port = var.ingress_values[0]
    protocol  = var.ingress_values[1]
    to_port   = var.ingress_values[2]
  }
}

# Object Example
output "config_output" {
  value = {
    provider_region = var.config.region
    count           = var.config.instance_count
    monitoring      = var.config.monitoring
  }
}

# Summary Output (mix types)
output "deployment_summary" {
  value = {
    env           = var.environment
    instances     = var.instance_count
    instance_name = var.tags["Name"]
  }
}
