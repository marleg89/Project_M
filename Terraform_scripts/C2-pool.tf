resource "libvirt_pool" "mypool" {
  name = var.poolname
  type = "dir"
  path = var.poolpath
}