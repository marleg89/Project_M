resource "libvirt_cloudinit_disk" "commoninit" {
  name      = "${var.hostname}-commoninit.iso"
  pool      = libvirt_pool.mypool.name
  user_data = data.template_file.user_data.rendered
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

