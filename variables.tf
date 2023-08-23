variable "name" {
  type        = string
  description = "Name to use for resources"
}

variable "vpc_cidr_range" {
  type        = string
  description = "CIDR Range for the VPC"
}

variable "worker_subnet_cidr_ranges" {
  type        = list(string)
  description = "CIDR Range for the worker subnets"
}

variable "control_plane_subnet_cidr_ranges" {
  type        = list(string)
  description = "CIDR Range for the control-plane subnets"
}

variable "ingress_subnet_cidr_ranges" {
  type        = list(string)
  description = "CIDR Range for the ingress subnets"
}

variable "rds_subnet_cidr_ranges" {
  type        = list(string)
  description = "CIDR Range for the RDS subnets. Two recommended"
  default     = []
}

variable "elasticache_msk_subnet_cidr_ranges" {
  type        = list(string)
  description = "CIDR Range for the Elasticache and MSK subnets. Three recommended"
  default     = []
}