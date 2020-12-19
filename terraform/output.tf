output "vpc_id" {
  description = "ID of VPC to install vertica cluster"
  value       = module.vertica_cluster.vpc_id
}

output "public_subnet_id" {
  description = "ID of public subnet to install vertica cluster. Used for bastion"
  value       = module.vertica_cluster.public_subnet_id
}

output "private_subnet_id" {
  description = "ID of public subnet to install vertica cluster. Used for nodes"
  value       = module.vertica_cluster.private_subnet_id
}

output "ssh_key_name" {
  description = "Name of key pair to use for ssh"
  value       = module.vertica_cluster.ssh_key_name
}

output "security_group_name" {
  description = "Name of security group that allows traffic for vertica communication"
  value       = module.vertica_cluster.security_group_name
}

output "communal_storage_bucket" {
  description = "Name of s3 bucket to hold communal data"
  value       = module.vertica_cluster.communal_storage_bucket
}

output "mc_id" {
  description = "Management Console id"
  value       = module.vertica_cluster.mc_id
}

output "mc_public_ip" {
  description = "Public ip of Managment Console"
  value       = module.vertica_cluster.mc_public_ip
}

output "mc_private_ip" {
  description = "Private ip of Managment Console"
  value       = module.vertica_cluster.mc_private_ip
}

output "node_ids" {
  description = "List of node ids"
  value       = module.vertica_cluster.node_ids
}

output "node_primary_host" {
  description = "Host of primary node"
  value       = try(module.vertica_cluster.node_private_ips[0], "")
}

output "node_public_ips" {
  description = "List of public ips of nodes"
  value       = module.vertica_cluster.node_public_ips
}


output "node_private_ips" {
  description = "List of private ips of nodes"
  value       = module.vertica_cluster.node_private_ips
}

output "lb_dns_name" {
  description = "DNS Name of Load Balancer"
  value       = module.vertica_cluster.lb_dns_name
}

output "db_user" {
  description = "Vertica db username"
  value       = var.db_user
}

output "db_name" {
  description = "Name of the database"
  value       = var.db_name
}

output "db_port" {
  description = "Port of the database"
  value       = var.db_port
}
