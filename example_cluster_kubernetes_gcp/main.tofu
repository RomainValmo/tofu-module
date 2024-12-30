module "cluster_kubernetes_gcp" {
  source = "github.com/RomainValmo/tofu-module//modules/cluster_kubernetes_gcp?ref=main"

  gcp_project_id       = var.gcp_project_id
  gcp_region           = var.gcp_region
  gcp_credentials_file = var.gcp_credentials_file
  worker               = var.worker
  masternode           = var.masternode
  private_key_ssh      = var.private_key_ssh

}
