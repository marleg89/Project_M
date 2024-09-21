resource "libvirt_volume" "base" {
  count  = var.num_vms
  name   = "${var.hostname}-${count.index}-base"
  pool   = libvirt_pool.mypool.name
  source = "${path.module}/deb-cloudimg-amd64.img"
  format = "qcow2"
}

resource "libvirt_volume" "cluster" {
  count          = var.num_vms
  name           = "${var.hostname}-${count.index}-disk"
  base_volume_id = libvirt_volume.base[count.index].id
  pool           = libvirt_pool.mypool.name
  size           = 10737418240
}