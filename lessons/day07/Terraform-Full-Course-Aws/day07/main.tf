# Task 1: S3 bucket name simulation
resource "null_resource" "task1_bucket" {
  triggers = {
    bucket_name = "${var.environment}-resource-name"
  }
}

# Task 2: Create N fake instances
resource "null_resource" "task2_instances" {
  count = var.instance_count

  triggers = {
    instance_number = count.index
  }
}

# Task 3: Boolean simulation
resource "null_resource" "task3_monitoring" {
  triggers = {
    monitoring = tostring(var.monitoring_enabled)
    public_ip  = tostring(var.associate_public_ip)
  }
}

# Task 4: VPC + subnets CIDR simulation
resource "null_resource" "task4_network" {
  triggers = {
    vpc_cidr     = var.cidr_block[0]
    subnet1_cidr = var.cidr_block[1]
    subnet2_cidr = var.cidr_block[2]
  }
}

# Task 5: Instance type validation simulation
resource "null_resource" "task5_instance_type" {
  triggers = {
    instance_type = var.instance_type
  }
}

# Task 6: Region validation already handled in variable validation

# Task 7: Tags simulation
resource "null_resource" "task7_tags" {
  triggers = var.tags
}

# Task 8: Tuple simulation
resource "null_resource" "task8_ingress" {
  triggers = {
    from_port = var.ingress_values[0]
    protocol  = var.ingress_values[1]
    to_port   = var.ingress_values[2]
  }
}

# Task 9: Object config simulation
resource "null_resource" "task9_config" {
  triggers = {
    region     = var.config.region
    monitoring = tostring(var.config.monitoring)
    count      = tostring(var.config.instance_count)
  }
}
