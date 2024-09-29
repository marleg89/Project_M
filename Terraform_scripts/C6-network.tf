resource "libvirt_network" "bridged_nic" {
  # the name used by libvirt
  name = "mybridge"

  mode = "bridge"

  bridge = "br0"
}