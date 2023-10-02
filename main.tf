output "vm_deployment" {
  #   value = local.generated_password
  value = [for vm in var.vm : format(<<EOT
Deploying Server:
  Server_Name = %s
  vsphere_cluster = %s
  Template_name = %s
  dns_domain = %s
  ipv4_address = %s
  cpu/mem = %s / %s
  domain_adminuser = %s
  default_gateway = %s
EOT
, vm.vm_name, var.vsphere_cluster, vm.template_name,
var.dns_domain, vm.ipv4_address,
# local.generated_password[vm.vm_name],
vm.vm_cpu, vm.vm_memory,
local.domain_admin_user,
var.ipv4_gateway
)]
  # sensitive = true
}

 # Local_admin_password = %s
