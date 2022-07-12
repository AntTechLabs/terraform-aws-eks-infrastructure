data "aws_availability_zones" "available" {}

#=========================== Public Subnets ===============================

resource "aws_subnet" "public_subnets" {
  count                   = var.public_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = {
    Name = "${var.env}-public-subnet-${count.index + 1}"
  }

  lifecycle {
    ignore_changes = [
      map_public_ip_on_launch
    ]
  }
}


#=========================== Private Subnets ===============================

resource "aws_subnet" "private_subnets" {
  count                   = var.private_subnets
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_cidrs[count.index]
  map_public_ip_on_launch = false
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null

  tags = {
    Name = "${var.env}-private-subnet-${count.index + 1}"
  }
}
