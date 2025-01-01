resource "aws_instance" "worker_node" {
  for_each = var.workernode

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.kube_key.key_name
  tags = {
    Name = each.key
  }


  network_interface {
    network_interface_id = aws_network_interface.kube_aws_nic_worker[each.key].id
    device_index         = 0
  }

  ebs_block_device {
    device_name = each.value.device_name
    volume_size = each.value.size_disk
    volume_type = each.value.disk_type
  }

  provisioner "remote-exec" {
    inline = [
      "curl -o /tmp/worker.sh https://raw.githubusercontent.com/RomainValmo/Kubernetes/main/Install_kube_cilium_helm/worker.sh",
      "chmod +x /tmp/worker.sh",
      "sudo /tmp/worker.sh",
      "rm -rf /tmp/worker.sh"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_host
      private_key = file(var.private_key_ssh)
      host        = aws_instance.worker_node[each.key].public_ip
    }
  }
}

resource "aws_network_interface" "kube_aws_nic_worker" {
  for_each = var.workernode

  subnet_id       = aws_subnet.kube_aws_subnet.id
  security_groups = [aws_security_group.kube_worker_sg.id]
}