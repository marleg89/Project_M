// Create the machine
resource "libvirt_domain" "domain-debian" {
  count = var.num_vms

  name       = "${var.hostname}-${count.index}"
  memory     = var.memoryMB
  vcpu       = var.cpu
  qemu_agent = true

  disk {
    volume_id = libvirt_volume.cluster[count.index].id
  }
  network_interface {
    network_name     = libvirt_network.bridged_nic.name
    wait_for_lease = true
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id


  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }
}

output "masters_ips" {
  value = {
    master = libvirt_domain.domain-debian[0].network_interface[0].addresses[0]
  }
}

output "workers_ips" {
  value = { for idx in range(1, var.num_vms):
    "worker${idx}" => libvirt_domain.domain-debian[idx].network_interface[0].addresses[0]
  }
}
