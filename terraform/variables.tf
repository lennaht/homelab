variable "pm_api_url" {
  type        = string
  description = "The URL of the API endpoint of the Proxmox node"
}

variable "pm_api_token_id" {
  type        = string
  description = "Identifier of API token"
  sensitive   = true
}

variable "pm_api_token_secret" {
  type        = string
  description = "Api-Key for specified Proxmox user"
  sensitive   = true
}

variable "pm_target_node" {
  type        = string
  description = "The Proxmox node to provision the VMs on"
  default     = "pve"
}

variable "vm_base_id" {
  type        = number
  description = "The base number of provisioned VM ids. IDs are incremented"
  default     = 801
}

variable "vm_base_name" {
  type        = string
  description = "Index of VM is concatenated after this"
  default     = "kube-"
}

resource "tls_private_key" "id_rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

output "private_key" {
  value     = tls_private_key.id_rsa.private_key_pem
  sensitive = true
}

variable "ciuser" {
  type        = string
  description = "Username for cloud-init"
  default     = "root"
}

variable "cipassword" {
  type        = string
  description = "Password for cloud-init user"
  sensitive   = true
}

variable "cigateway" {
  type        = string
  description = "IP of gateway"
}

variable "ci_ipadresses" {
  type        = list(string)
  description = "IP adresses in CIDR notation. Length determines the number of VMs"
}
