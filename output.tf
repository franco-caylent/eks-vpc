output "vpc_id" {
  value = module.vpc.vpc_id
}

output "ingress_subnets" {
  value = module.vpc.redshift_subnets
}

output "worker_subnets" {
  value = module.vpc.private_subnets
}

output "worker_subnets_cidr_blocks" {
  value = module.vpc.private_subnets_cidr_blocks
}

output "control_plane_subnets" {
  value = module.vpc.intra_subnets
}

output "rds_subnets" {
  value = module.vpc.database_subnets
}

output "elasticache_msk_subnets" {
  value = module.vpc.elasticache_subnets
}

output "tgw_attached_route_table_ids" {
  value = concat(module.vpc.private_route_table_ids, module.vpc.intra_route_table_ids, module.vpc.redshift_route_table_ids)
}

output "availability_zones" {
  value = module.vpc.azs
}
