resource "null_resource" "ansible_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      # Start by defining the group [vms]
      echo "[worker]" > inventory.ini
      %{ for vm in libvirt_domain.domain-debian }
        %{ if vm.name != "node-0" }
          echo "${vm.name} ansible_host=${vm.network_interface.0.addresses[0]}" >> inventory.ini
        %{ endif }
      %{ endfor }

      # Add vm-0 to a special group
      echo "[control-plane]" >> inventory.ini
      echo "node-0 ansible_host=${libvirt_domain.domain-debian[0].network_interface.0.addresses[0]}" >> inventory.ini
      echo "[all:vars]" >> inventory.ini
      echo "ansible_user=debian" >> inventory.ini
      echo "ansible_password=debian" >> inventory.ini
      echo "ansible_become_password=debian" >> inventory.ini
      cp -f inventory.ini ../Ansible_scripts
    EOT
  }

  depends_on = [libvirt_domain.domain-debian]
}