output "instance_external_ip_master_node" {
  value = { for instance_name, instance in aws_instance.control_plan : 
    instance_name => instance.public_ip
  }
}

output "private_ips_master_node" {
  value = { for key, nic in aws_network_interface.kube_aws_nic_master : key => nic.private_ip }
}

output "instance_external_ip_worker_node" {
  value = { for instance_name, instance in aws_instance.worker_node : 
    instance_name => instance.public_ip
  }
}

output "private_ips_worker_node" {
  value = { for key, nic in aws_network_interface.kube_aws_nic_worker : key => nic.private_ip }
}

