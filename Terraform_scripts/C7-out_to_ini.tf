resource "null_resource" "ansible_inventory" {
  provisioner "local-exec" {
    command = <<EOT
      # Création du fichier d'inventaire
      echo "[control-plane]" > inventory.ini
      %{ for i in range(0, length(libvirt_domain.domain-debian)) }
        %{ if i < 3 }
          echo "${element(libvirt_domain.domain-debian, i).name} ansible_host=${element(libvirt_domain.domain-debian, i).network_interface.0.addresses[0]}" >> inventory.ini
        %{ endif }
      %{ endfor }

      echo "[load-balancer]" >> inventory.ini
      %{ for i in range(0, length(libvirt_domain.domain-debian)) }
        %{ if i >= 3 && i < 5 }
          echo "${element(libvirt_domain.domain-debian, i).name} ansible_host=${element(libvirt_domain.domain-debian, i).network_interface.0.addresses[0]}" >> inventory.ini
        %{ endif }
      %{ endfor }

      echo "[worker]" >> inventory.ini
      %{ for i in range(0, length(libvirt_domain.domain-debian)) }
        %{ if i >= 5 }
          echo "${element(libvirt_domain.domain-debian, i).name} ansible_host=${element(libvirt_domain.domain-debian, i).network_interface.0.addresses[0]}" >> inventory.ini
        %{ endif }
      %{ endfor }

      echo "[all:vars]" >> inventory.ini
      echo "ansible_user=debian" >> inventory.ini
      echo "ansible_password=debian" >> inventory.ini
      echo "ansible_become_password=debian" >> inventory.ini
      cp -f inventory.ini ${var.inipath}
    EOT
  }

  depends_on = [libvirt_domain.domain-debian]
}