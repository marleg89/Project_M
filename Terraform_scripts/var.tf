variable "num_vms" {
  description = "Number of VMs to create"
  type        = number
  default     = 5
}

variable "hostname" {
  default = "node"
}

variable "poolname" {
  default = "mypool"
}

variable "poolpath" {
  type = string
}

variable "volname" {
  default = "myvol"
}

variable "domain" {
  default = "private.mlg"
}

variable "ip_type" {
  default = "dhcp"
}

variable "memoryMB" {
  default = 2048 * 1
}

variable "cpu" {
  default = 2
}

variable "disk_size_gb" {
  description = "Size of the disk (in GB) for each VM"
  type        = number
  default     = 10737418240 # 10 Gb
}

variable "organization" {
  type = string
}

variable "workspace" {
  type = string
}