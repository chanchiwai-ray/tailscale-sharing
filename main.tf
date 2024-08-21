# https://registry.terraform.io/providers/terraform-lxd/lxd/latest/docs
terraform {
  required_providers {
    lxd = {
      source  = "terraform-lxd/lxd"
      version = "2.2.0"
    }
  }
}

provider "lxd" {
}

resource "lxd_instance" "runner" {
  count = var.num
  name  = "runner-${uuid()}"
  image = var.image

  config = {
    "boot.autostart"       = true
    "cloud-init.user-data" = <<-EOT
    #cloud-config
    runcmd:
      - ["sh", "-c", "curl -fsSL https://tailscale.com/install.sh | sh"]
      - ["tailscale", "up", "--authkey=${var.auth_key}", "--ssh"]
    EOT
  }

  limits = {
    cpu    = var.cpu
    memory = var.memory
  }
}
