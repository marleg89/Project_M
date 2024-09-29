terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.6"
    }
  }
}

terraform {
  required_version = ">= 1.6.6"
  cloud {
    organization = "marleg89_org"
    workspaces {
      name = "Workspace_mlg"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
