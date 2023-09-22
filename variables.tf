variable "vsphere_user" {
  type      = string
  default   = ""
  sensitive = true
}
variable "vsphere_password" {
  type      = string
  sensitive = true
  default   = ""
}
variable "vsphere_server" {
  type      = string
  default   = ""
}
variable "vsphere_datacenter" {
  type    = string
  default = ""
}
variable "vsphere_datastore" {
  type    = string
  default = ""
}
variable "vsphere_cluster" {
  type    = string
  default = ""
}
variable "vsphere_folder" {
  type    = string
  default = ""
}
variable "vsphere_network" {
  type    = string
}
variable "ipv4_gateway" {
  type    = string
  validation {
    condition = can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ipv4_gateway))
    error_message = "Invalid format of ipv4_gateway address provided."
  }
}
variable "ipv4_netmask" {
  type    = number
}
variable "Zone" {
  type    = number
}
variable "VLAN" {
  type    = number
}

variable "local_adminpass" {
  type    = string
  default = ""
}
variable "domain" {
  type    = string
  default = ""
}
variable "domain_admin_user" {
  type    = string
  default = ""
}
variable "domain_admin_password" {
  type    = string
  default = ""
}
variable "domain_name" {
  type    = string
  default = ""
}
variable "dns_server_list" {
  type    = list(string)
  default = []
}
variable "dns_domain" {
  type    = string
  default = ""
}
variable "dns_suffix_list" {
  type    = list(string)
  default = []
}

variable "vm" {
  type = list(object({
    vm_name         = string
    Host_name       = string
    Description     = string
    ManagedBy       = string
    GroupMember     = string
    template_name   = string
    ipv4_address    = string
    vm_memory       = number
    vm_cpu          = number
  }))
  validation {
    condition = alltrue([
      for vm in var.vm : can(regex("(?i)^vn[[:alpha:]]{1}[[:digit:]]{3,5}$", vm.vm_name))
    ])
    error_message = "Vmname invalid, Must be formatted as follows: 'vnn01234' starting with 'vn' followed by a letter and the number part being between 3 and 5 digits long."
  }
  validation {
    condition     = length(var.vm) == length(distinct(var.vm[*].vm_name))
    error_message = "Each vm name must be unique."
  }
  validation {
    condition     = length(var.vm) == length(distinct(var.vm[*].ipv4_address))
    error_message = "Each vm IP must be unique."
  }
  validation {
    condition     = length(var.vm) == length(distinct(var.vm[*].Host_name))
    error_message = "Each vm hostname must be unique."
  }
  validation {
    condition = alltrue([
      for vm in var.vm : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", vm.ipv4_address))
    ])
    error_message = "Invalid format of ipv4_address address provided."
  }
 
}