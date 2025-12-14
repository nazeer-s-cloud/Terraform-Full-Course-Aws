# us-east-1 ↔ us-west-2

resource "aws_vpc_peering_connection" "use1_usw2" {
  provider    = aws.use1
  vpc_id      = aws_vpc.use1.id
  peer_vpc_id = aws_vpc.usw2.id
  peer_region = "us-west-2"

  tags = {
    Name = "use1-usw2"
  }
}

resource "aws_vpc_peering_connection_accepter" "usw2_accept" {
  provider                  = aws.usw2
  vpc_peering_connection_id = aws_vpc_peering_connection.use1_usw2.id
  auto_accept               = true
}

# us-east-1 ↔ ap-south-1

resource "aws_vpc_peering_connection" "use1_aps1" {
  provider    = aws.use1
  vpc_id      = aws_vpc.use1.id
  peer_vpc_id = aws_vpc.aps1.id
  peer_region = "ap-south-1"

  tags = {
    Name = "use1-aps1"
  }
}

resource "aws_vpc_peering_connection_accepter" "aps1_accept_use1" {
  provider                  = aws.aps1
  vpc_peering_connection_id = aws_vpc_peering_connection.use1_aps1.id
  auto_accept               = true
}

# us-west-2 ↔ ap-south-1

resource "aws_vpc_peering_connection" "usw2_aps1" {
  provider    = aws.usw2
  vpc_id      = aws_vpc.usw2.id
  peer_vpc_id = aws_vpc.aps1.id
  peer_region = "ap-south-1"

  tags = {
    Name = "usw2-aps1"
  }
}

resource "aws_vpc_peering_connection_accepter" "aps1_accept_usw2" {
  provider                  = aws.aps1
  vpc_peering_connection_id = aws_vpc_peering_connection.usw2_aps1.id
  auto_accept               = true
}
