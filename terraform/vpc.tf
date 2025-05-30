resource "aws_vpc" "new-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = var.vpc_tags
}
/* evaluate availability zone
data "aws_availability_zones" "available" {}
output "az" {
    value = "${data.aws_availability_zones.available.names}"
}
*/
data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnets" {
    count = 2
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id     = aws_vpc.new-vpc.id
    cidr_block = "10.0.${count.index}.0/24"
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.prefix}-vpc-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new-vpc.id
  tags = var.igw_tags
}

resource "aws_route_table" "new-rtb" {
  vpc_id = aws_vpc.new-vpc.id
  route {
    cidr_block = var.rtb_cidr_block
    gateway_id = aws_internet_gateway.new-igw.id
  }
  tags = var.rtb_tags
}

resource "aws_route_table_association" "new-rtb-association" {
  count = 2
  route_table_id = aws_route_table.new-rtb.id
  subnet_id = aws_subnet.subnets.*.id[count.index]
}