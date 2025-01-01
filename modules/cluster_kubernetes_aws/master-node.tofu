resource "aws_key_pair" "kube_key" {
  key_name   = "kube-key"
  public_key = file(var.ssh_key)
}

resource "aws_instance" "control_plan" {
  for_each = var.masternode

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = aws_key_pair.kube_key.key_name
  tags = {
    Name = each.key
  }


  network_interface {
    network_interface_id = aws_network_interface.kube_aws_nic_master[each.key].id
    device_index         = 0
  }

  ebs_block_device {
    device_name = each.value.device_name
    volume_size = each.value.size_disk
    volume_type = each.value.disk_type
  }

  provisioner "remote-exec" {
    inline = [
      "curl -o /tmp/master.sh https://raw.githubusercontent.com/RomainValmo/Kubernetes/main/Install_kube_cilium_helm/master.sh",
      "chmod +x /tmp/master.sh",
      "sudo /tmp/master.sh",
      "rm -rf /tmp/master.sh"
    ]

    connection {
      type        = "ssh"
      user        = var.ssh_host
      private_key = file(var.private_key_ssh) # Chemin vers la clé privée SSH
      host        = aws_instance.control_plan[each.key].public_ip
    }
  }
}

resource "aws_network_interface" "kube_aws_nic_master" {
  for_each = var.masternode

  subnet_id       = aws_subnet.kube_aws_subnet.id
  security_groups = [aws_security_group.kube_master_sg.id]
}

