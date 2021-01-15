resource "digitalocean_ssh_key" "default" {
  name       = "default"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "digitalocean_droplet" "web" {
  image  = "ubuntu-18-04-x64"
  name   = "web-1"
  region = "fra1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.default.fingerprint
  ]
}

resource "digitalocean_domain" "default" {
  name = "tft.sikademo.com"
}

resource "digitalocean_record" "web1" {
  domain = digitalocean_domain.default.name
  type   = "A"
  name   = "web1"
  value  = digitalocean_droplet.web.ipv4_address
}

output "web_ip" {
  value = digitalocean_droplet.web.ipv4_address
}

output "web_fqdn" {
  value = digitalocean_record.web1.fqdn
}
