resource "google_compute_network" "kube_gcp" {
  name                    = "kube-network"        
  auto_create_subnetworks = false                    
}

resource "google_compute_subnetwork" "kube_gcp_subnet" {
  name          = "kube-gcp-subnet"                   
  region        = var.gcp_region                      
  network       = google_compute_network.kube_gcp.self_link 
  ip_cidr_range = var.network_ip_range                       
}

resource "google_compute_firewall" "kube_gcp_firewall_worker" {
  name    = "kube-gcp-firewall-worker"                       
  network = google_compute_network.kube_gcp.self_link 

  allow {
    protocol = "tcp"
    ports    = ["30000-32767", "80", "443", "22" ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = [ "kube-node-port-worker" ]
}

resource "google_compute_firewall" "kube_gcp_firewall_masternode" {
  name    = "kube-gcp-firewall-masternode"                       
  network = google_compute_network.kube_gcp.self_link 

  allow {
    protocol = "tcp"
    ports    = [  "80", "443", "22" ]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = [ "kube-node-port-masternode" ]
}

resource "google_compute_firewall" "kube_gcp_firewall_masternode_6443" {
  name    = "kube-gcp-firewall-masternode-6443"                       
  network = google_compute_network.kube_gcp.self_link 

  allow {
    protocol = "tcp"
    ports    = [  "6443","10250", "10251", "10252", "10255", "2379", "2380", "53" ]
  }

  source_ranges = [var.network_ip_range]
  target_tags = [ "kube-node-port-masternode" ]
}

resource "google_compute_firewall" "default_allow_icmp" {
  name    = "default-allow-icmp-2"
  network = google_compute_network.kube_gcp.self_link

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = [ "kube-node-port-worker", "kube-node-port-masternode" ]
}

resource "google_compute_firewall" "default_allow_internal" {
  name    = "default-allow-internal-2"
  network = google_compute_network.kube_gcp.self_link

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.132.0.0/20"]
  target_tags = [ "kube-node-port-worker" ]
}

resource "google_compute_firewall" "default_allow_egress" {
  name    = "default-allow-egress-any-any"
  network = google_compute_network.kube_gcp.self_link

  direction = "EGRESS"  

  allow {
    protocol = "all"  
  }

  destination_ranges = ["0.0.0.0/0"]
  target_tags = [ "kube-node-port-worker", "kube-node-port-masternode" ] 
}
