# Internet Gateways

resource "aws_internet_gateway" "use1_igw" {
  provider = aws.use1
  vpc_id  = aws_vpc.use1.id
}

resource "aws_internet_gateway" "usw2_igw" {
  provider = aws.usw2
  vpc_id  = aws_vpc.usw2.id
}

resource "aws_internet_gateway" "aps1_igw" {
  provider = aws.aps1
  vpc_id  = aws_vpc.aps1.id
}

# Route Tables

resource "aws_route_table" "use1_rt" {
  provider = aws.use1
  vpc_id  = aws_vpc.use1.id
}

resource "aws_route_table" "usw2_rt" {
  provider = aws.usw2
  vpc_id  = aws_vpc.usw2.id
}

resource "aws_route_table" "aps1_rt" {
  provider = aws.aps1
  vpc_id  = aws_vpc.aps1.id
}

# Internet Routes

resource "aws_route" "use1_internet" {
  provider                 = aws.use1
  route_table_id           = aws_route_table.use1_rt.id
  destination_cidr_block   = "0.0.0.0/0"
  gateway_id               = aws_internet_gateway.use1_igw.id
}

resource "aws_route" "usw2_internet" {
  provider                 = aws.usw2
  route_table_id           = aws_route_table.usw2_rt.id
  destination_cidr_block   = "0.0.0.0/0"
  gateway_id               = aws_internet_gateway.usw2_igw.id
}

resource "aws_route" "aps1_internet" {
  provider                 = aws.aps1
  route_table_id           = aws_route_table.aps1_rt.id
  destination_cidr_block   = "0.0.0.0/0"
  gateway_id               = aws_internet_gateway.aps1_igw.id
}


#us-east-1 routes

resource "aws_route" "use1_to_usw2" {
  provider                       = aws.use1
  route_table_id                 = aws_route_table.use1_rt.id
  destination_cidr_block         = "10.1.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.use1_usw2.id
}

resource "aws_route" "use1_to_aps1" {
  provider                       = aws.use1
  route_table_id                 = aws_route_table.use1_rt.id
  destination_cidr_block         = "10.2.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.use1_aps1.id
}

resource "aws_route" "usw2_to_use1" {
  provider                       = aws.usw2
  route_table_id                 = aws_route_table.usw2_rt.id
  destination_cidr_block         = "10.0.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.use1_usw2.id
}

resource "aws_route" "usw2_to_aps1" {
  provider                       = aws.usw2
  route_table_id                 = aws_route_table.usw2_rt.id
  destination_cidr_block         = "10.2.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.usw2_aps1.id
}

resource "aws_route" "aps1_to_use1" {
  provider                       = aws.aps1
  route_table_id                 = aws_route_table.aps1_rt.id
  destination_cidr_block         = "10.0.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.use1_aps1.id
}

resource "aws_route" "aps1_to_usw2" {
  provider                       = aws.aps1
  route_table_id                 = aws_route_table.aps1_rt.id
  destination_cidr_block         = "10.1.0.0/16"
  vpc_peering_connection_id      = aws_vpc_peering_connection.usw2_aps1.id
}

# Route Table Associations

resource "aws_route_table_association" "use1_assoc" {
  provider       = aws.use1
  subnet_id      = aws_subnet.use1_subnet.id
  route_table_id = aws_route_table.use1_rt.id
}

resource "aws_route_table_association" "usw2_assoc" {
  provider       = aws.usw2
  subnet_id      = aws_subnet.usw2_subnet.id
  route_table_id = aws_route_table.usw2_rt.id
}

resource "aws_route_table_association" "aps1_assoc" {
  provider       = aws.aps1
  subnet_id      = aws_subnet.aps1_subnet.id
  route_table_id = aws_route_table.aps1_rt.id
}


