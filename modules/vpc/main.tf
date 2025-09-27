#General VPC
resource "aws_vpc" "lab3-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = var.vpc_tags
}
#VPC internet gateway
resource "aws_internet_gateway" "lab3-igw" {
  vpc_id = aws_vpc.lab3-vpc.id
  tags = var.igw-tags
}

#Private Subnets 
resource "aws_subnet" "lab3-private-subnet" {
  count= length(var.private_subnets)
  vpc_id = aws_vpc.lab3-vpc.id
  cidr_block = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = var.private_subnet_tags[count.index]
}

#Public Subnets
resource "aws_subnet" "lab3-public-subnet" {
  count= length(var.public_subnets)
  vpc_id = aws_vpc.lab3-vpc.id
  cidr_block = var.public_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = var.public_subnet_tags[count.index]
}

#------Private instances internet connection-------
#Elastic IP
resource "aws_eip" "lab3-nat-eip" {
  domain = "vpc"
  tags = var.eip_tags
  depends_on = [ aws_internet_gateway.lab3-igw ]
}

resource "aws_nat_gateway" "lab3-nat-gateway" {
  allocation_id = aws_eip.lab3-nat-eip.id
  subnet_id = aws_subnet.lab3-public-subnet[0].id
  tags = var.nat_tags

  depends_on = [ aws_internet_gateway.lab3-igw, aws_subnet.lab3-public-subnet ]
}


#-----------Route Tables
#Public Route Table
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.lab3-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab3-igw.id
  }
  tags = var.public_rt_tags
}

resource "aws_route_table_association" "public-rt-subnets" {
  count = length(aws_subnet.lab3-public-subnet)
  route_table_id = aws_route_table.public-rt.id
  subnet_id = aws_subnet.lab3-public-subnet[count.index].id
}

#Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.lab3-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.lab3-nat-gateway.id
  }
  tags = var.private_rt_tags
}

resource "aws_route_table_association" "private-rt-subnets" {
    count = length(aws_subnet.lab3-private-subnet)
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.lab3-private-subnet[count.index].id
}