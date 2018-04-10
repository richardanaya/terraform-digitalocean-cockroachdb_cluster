resource "digitalocean_droplet" "cockroach-1" {
  image = "ubuntu-17-10-x64"
  name = "cr-1"
  region = "nyc1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "wget -qO- https://binaries.cockroachdb.com/cockroach-v2.0.0.linux-amd64.tgz | tar xvz",
      "cd cockroach-v2.0.0.linux-amd64",
      "nohup ./cockroach start --insecure --host=$(hostname -I | awk '{ print $1 }')&",
      "sleep 1"
    ]
  }
}

resource "digitalocean_droplet" "cockroach-2" {
  image = "ubuntu-17-10-x64"
  name = "cr-2"
  region = "lon1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "wget -qO- https://binaries.cockroachdb.com/cockroach-v2.0.0.linux-amd64.tgz | tar xvz",
      "cd cockroach-v2.0.0.linux-amd64",
      "nohup ./cockroach start --insecure --host=$(hostname -I | awk '{ print $1 }') --join=${digitalocean_droplet.cockroach-1.ipv4_address}:26257 &",
      "sleep 1"
    ]
  }
}

resource "digitalocean_droplet" "cockroach-3" {
  image = "ubuntu-17-10-x64"
  name = "cr-3"
  region = "blr1"
  size = "s-1vcpu-1gb"
  private_networking = true
  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  connection {
    user = "root"
    type = "ssh"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }
  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      # install nginx
      "sudo apt-get update",
      "wget -qO- https://binaries.cockroachdb.com/cockroach-v2.0.0.linux-amd64.tgz | tar xvz",
      "cd cockroach-v2.0.0.linux-amd64",
      "nohup ./cockroach start --insecure --host=$(hostname -I | awk '{ print $1 }') --join=${digitalocean_droplet.cockroach-1.ipv4_address}:26257 &",
      "sleep 1"
    ]
  }
}

output "ip" {
  value = "${digitalocean_droplet.cockroach-1.ipv4_address}"
}
