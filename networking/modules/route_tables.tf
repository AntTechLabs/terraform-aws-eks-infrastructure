#===================== Public Route Table =========================

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-Public route table"
  }
}

resource "aws_route" "public_igw" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  route_table_id         = aws_route_table.public_route_table.id


  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.public_subnets
  subnet_id      = aws_subnet.public_subnets.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


#===================== Private Route Table ========================

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env} Private route table"
  }
}

resource "aws_route" "private_nat_gateway" {
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
  route_table_id         = aws_route_table.private_route_table.id

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private_assoc" {
  count          = var.private_subnets
  subnet_id      = aws_subnet.private_subnets.*.id[count.index]
  route_table_id = aws_route_table.private_route_table.id
}



resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[1].id

  tags = {
    Name = "${var.env}-NAT"
  }
}

resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.env} EIP for nat"
  }
}