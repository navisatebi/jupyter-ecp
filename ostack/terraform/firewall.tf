resource "openstack_compute_secgroup_v2" "allow-icmp" {
  name        = "${var.name}-allow-icmp"
  description = "Allow ICMP traffic"

  rule {
    ip_protocol = "icmp"
    from_port   = -1
    to_port     = -1
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "allow-ssh" {
  name        = "${var.name}-allow-ssh"
  description = "Allow SSH traffic"

  rule {
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_secgroup_v2" "allow-https" {
  name        = "${var.name}-allow-https"
  description = "Allow HTTPS traffic"

  rule {
    ip_protocol = "tcp"
    from_port   = 443
    to_port     = 443
    cidr        = "0.0.0.0/0"
  }
}
