output "cluster_name" {
  value = module.eks.cluster_name
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "node_group_name" {
  value = module.nodegroup.node_group_name
}

output "vpc_id" {
  value = module.vpc.vpc_id
}