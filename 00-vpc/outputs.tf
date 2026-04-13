output "available_zones" {
  value = data.aws_availability_zones.available.names
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
}

output "db_private_subnet_ids" {
  value = module.vpc.db_private_subnet_ids
}