output "vpc_ids" {
  value = {
    us_east_1 = aws_vpc.use1.id
    us_west_2 = aws_vpc.usw2.id
    ap_south_1 = aws_vpc.aps1.id
  }
}

output "peering_connections" {
  value = {
    use1_usw2 = aws_vpc_peering_connection.use1_usw2.id
    use1_aps1 = aws_vpc_peering_connection.use1_aps1.id
    usw2_aps1 = aws_vpc_peering_connection.usw2_aps1.id
  }
}

output "public_ips" {
  value = {
    use1 = aws_instance.use1_ec2.public_ip
    usw2 = aws_instance.usw2_ec2.public_ip
    aps1 = aws_instance.aps1_ec2.public_ip
  }
}

output "private_ips" {
  value = {
    use1 = aws_instance.use1_ec2.private_ip
    usw2 = aws_instance.usw2_ec2.private_ip
    aps1 = aws_instance.aps1_ec2.private_ip
  }
}
