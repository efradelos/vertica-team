output "node_ids" {
  description = "List of node ids"
  value       = module.vertica_cluster.node_ids
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
  value       = module.vertica_cluster.lb_dns_name[0]
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
