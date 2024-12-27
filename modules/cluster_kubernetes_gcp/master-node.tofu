locals {
  ssh_keys = { for key, node in var.masternode :
    key => "${node.ssh-host}:${file(node.ssh-file)}"
  }
  ssh_host = { for key, node in var.masternode :
    key => node.ssh-host
  }
}

resource "google_compute_instance" "control_plan" {
  for_each = var.masternode
  name         = each.key
  machine_type = each.value.instance_type
  zone         = each.value.zone
  allow_stopping_for_update = each.value.allow_stopping_for_update
    tags         = var.tag_masternote
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
  ssh-keys = local.ssh_keys[each.key]
}
}

output "instance_external_ip" {
  value = { for instance_name, instance in google_compute_instance.control_plan : 
    instance_name => instance.network_interface[0].access_config[0].nat_ip
  }
}

resource "null_resource" "remote_script_execution" {
  for_each = google_compute_instance.control_plan
  depends_on = [google_compute_instance.control_plan] 

  provisioner "file" {
    source      = var.path_master
    destination = "/tmp/remote-script.sh"

    connection {
      type        = "ssh"
      user        = local.ssh_host[each.key]
      private_key = file(var.private_key_ssh)
      host        = each.value.network_interface[0].access_config[0].nat_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/remote-script.sh",  
      "sudo /tmp/remote-script.sh"       
    ]

    connection {
      type        = "ssh"
      user        = local.ssh_host[each.key]
      private_key = file(var.private_key_ssh)
      host        = each.value.network_interface[0].access_config[0].nat_ip
    }
  }
}
