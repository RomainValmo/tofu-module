locals {
  ssh_keys_worker = { for key, node in var.worker :
    key => "${node.ssh-host}:${file(node.ssh-file)}"
  }
  ssh_host_worker = { for key, node in var.worker :
    key => node.ssh-host
  }
}


resource "google_compute_instance" "worker_node" {
  for_each = var.worker
  name         = each.key
  machine_type = each.value.instance_type
  zone         = each.value.zone
  allow_stopping_for_update = each.value.allow_stopping_for_update
    tags         = var.tag_worker
  boot_disk {
    initialize_params {
      image = each.value.image
      size =  each.value.size_disk
      type  = each.value.disk_type
    }
  }
  network_interface {
      network = google_compute_network.kube_gcp.self_link
      subnetwork = google_compute_subnetwork.kube_gcp_subnet.self_link
      access_config {     

       }
 }
  service_account {
    scopes = ["cloud-platform"]
  }
metadata = {
  ssh-keys = local.ssh_keys_worker[each.key]
}
}

output "instance_external_ip_worker" {
  value = { for instance_name, instance in google_compute_instance.worker_node : 
    instance_name => instance.network_interface[0].access_config[0].nat_ip
  }
}


resource "null_resource" "remote_script_execution_worker" {
  for_each = google_compute_instance.worker_node
  depends_on = [google_compute_instance.worker_node]

  provisioner "remote-exec" {
    inline = [
      "curl -o /tmp/worker.sh https://raw.githubusercontent.com/RomainValmo/Kubernetes/main/Install_kube_cilium_helm/worker.sh",
      "chmod +x /tmp/worker.sh",
      "sudo /tmp/worker.sh",
      "rm -rf /tmp/worker.sh"
    ]
    connection {
      type        = "ssh"
      user        = local.ssh_host_worker[each.key]
      private_key = file(var.private_key_ssh)
      host        = each.value.network_interface[0].access_config[0].nat_ip 
    }
  }
}

