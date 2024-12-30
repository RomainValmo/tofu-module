module "cluster_kubernetes_gcp" {
  source = "github.com/RomainValmo/tofu-module//modules/cluster_kubernetes_aws?ref=main"

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  masternode = var.masternode
  workernode = var.workernode
  ssh_key   = var.ssh_key
  ssh_private_key = var.ssh_private_key

}
