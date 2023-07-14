variable hostname {
  type        = string
  description = "The hostname for the VM (doubles as the VM name)."
}

variable template_name {
  type        = string
  description = "The name of the template to clone."
}

variable network_name {
  type        = string
  description = "The name of the network to which to connect the VM."
  default     = "VM Network"
}
variable ipv4_address {
  type        = string
  description = "The IPv4 address to assign to the VM."
  default     = null
}
variable ipv4_netmask {
  type        = string
  description = "The IPv4 netmask to assign to the VM."
  default     = null
}
variable ipv4_gateway {
  type        = string
  description = "The IPv4 gateway to assign to the VM."
  default     = null
}

variable ipv6_address {
  type        = string
  description = "The IPv6 address to assign to the VM."
  default     = null
}
variable ipv6_netmask {
  type        = string
  description = "The IPv6 netmask to assign to the VM."
  default     = null
}
variable ipv6_gateway {
  type        = string
  description = "The IPv6 gateway to assign to the VM."
  default     = null
}

variable dns_servers {
  type        = list(string)
  description = "The DNS servers to assign to the VM."
  default     = ["1.1.1.1"]
}

variable domain {
  type        = string
  description = "The DNS suffix to assign to the VM."
}

variable vCPUs {
  type        = number
  description = "The number of vCPUs to assign to the VM."
  default     = 2
}

variable memory {
  type        = number
  description = "The amount of memory in MB to assign to the VM."
  default     = 2048
}

variable datacenter_name {
  type        = string
  description = "The name of the vSphere Datacenter to which the VM will be assigned."
}
variable cluster_name {
  type        = string
  description = "The vSphere Cluster on which the VM will be created."
}
variable datastore_name {
  type        = string
  description = "The vSphere Datastore in which the VM's disks will be stored."
}
variable vm_folder {
  type        = string
  description = "The VM folder into which the the VM will be placed."
}

variable username {
  type        = string
  description = "The username with which to log into the VM."
}
variable private_key {
  type        = string
  description = "The private key with which to log into the VM."
  sensitive   = true
}
