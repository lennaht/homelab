resource "proxmox_vm_qemu" "vm" {
  count = length(var.ci_ipadresses)

  name        = "${var.vm_base_name}${count.index}"
  target_node = var.pm_target_node
  vmid        = var.vm_base_id + count.index

  clone    = "ubuntu-cloud-template"
  os_type  = "cloud-init"
  memory   = 3072
  cores    = 2
  onboot   = false
  oncreate = false
  agent    = 1
  scsihw   = "virtio-scsi-pci"
  qemu_os  = "other"

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    slot    = 0
    storage = "local-lvm"
    type    = "scsi"
    size    = "40G"
  }

  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys    = tls_private_key.id_rsa.public_key_openssh
  ipconfig0  = "ip=${var.ci_ipadresses[count.index]},gw=${var.cigateway}"

  tags = "k8s;terraform"
}
