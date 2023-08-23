terraform {
  required_version = ">= 1.4"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.64"
    }
  }
}

data "aws_region" "current" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.2"

  name = var.name
  cidr = var.vpc_cidr_range

  azs = ["${data.aws_region.current.name}a", "${data.aws_region.current.name}b", "${data.aws_region.current.name}c"]
  # Worker Nodes Subnet
  private_subnets       = var.worker_subnet_cidr_ranges
  private_subnet_suffix = "worker"
  private_subnet_tags = {
    "description" : "EKS Worker Nodes"
    "kubernetes.io/cluster/${var.name}" : "owned" # Dont use the module output due to cycle
  }
  # Subnets for control plane
  intra_subnets       = var.control_plane_subnet_cidr_ranges
  intra_subnet_suffix = "control-plane"
  intra_subnet_tags = {
    "description" : "EKS Control Plane ENIs"
    "kubernetes.io/cluster/${var.name}" : "owned" # Dont use the module output due to cycle
  }
  # Subnets for RDS
  database_subnets       = var.rds_subnet_cidr_ranges
  database_subnet_suffix = "rds"
  database_subnet_tags = {
    "description" : "RDS ENIs"
  }
  # Subnets for Elasticache
  elasticache_subnets       = var.elasticache_msk_subnet_cidr_ranges
  elasticache_subnet_suffix = "elasticache-msk"
  elasticache_subnet_tags = {
    "description" : "Elasticache and MSK ENIs"
  }
  # Subnets for Ingress
  redshift_subnets       = var.ingress_subnet_cidr_ranges
  redshift_subnet_suffix = "ingress"
  redshift_subnet_tags = {
    "name" : "eks-nlb"
    "description" : "EKS NLB ENIs"
    "kubernetes.io/cluster/${var.name}" : "owned" # Dont use the module output due to cycle
    "kubernetes.io/role/internal-elb" : "1"
  }
  # VPC Configuration
  enable_ipv6          = false
  enable_dns_hostnames = true
  enable_dns_support   = true
}
