#VPC ID output
output "lab3_vpc_id" {
  value = aws_vpc.lab3-vpc.id
}

# --- Subnet Outputs---
output "public_subnet_ids" {
  description = "List of public subnet IDs across AZs"
  value       = aws_subnet.lab3-public-subnet[*].id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs across AZs"
  value       = aws_subnet.lab3-private-subnet[*].id
}

# --- Gateway Outputs ---
output "igw_id" {
  value = aws_internet_gateway.lab3-igw.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.lab3-nat-gateway.id
}