module "cluster_kubernetes_aws" {
  source = "github.com/RomainValmo/tofu-module//modules/cluster_kubernetes_aws?ref=main"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  masternode = var.masternode
  workernode = var.workernode
  ssh_key   = var.ssh_key
  private_key_ssh = var.private_key_ssh
}

output "master_node_external_ips" {
  description = "Adresses IP externes des master nodes"
  value       = module.cluster_kubernetes_aws.instance_external_ip_master_node
}

output "master_node_private_ips" {
  description = "Adresses IP privées des master nodes"
  value       = module.cluster_kubernetes_aws.private_ips_master_node
}

output "worker_node_external_ips" {
  description = "Adresses IP externes des worker nodes"
  value       = module.cluster_kubernetes_aws.instance_external_ip_worker_node
}

output "worker_node_private_ips" {
  description = "Adresses IP privées des worker nodes"
  value       = module.cluster_kubernetes_aws.private_ips_worker_node
}
