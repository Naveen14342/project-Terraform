output "vpc_id" {
    value = module.aws_vpc.vpc_id

  
}

output "public_subnet_ids" {
    value = module.aws_subnet.public[*].id
}

output "private_subnet_ids" {
    value = module.aws_subnet.private[*].id
  
}