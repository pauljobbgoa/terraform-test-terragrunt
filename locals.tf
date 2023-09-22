locals {
  server_name_detail = {
    for vm in var.vm : vm.vm_name =>
    #regex that creates and object of 4 attributes of the vm_name (i.e. vnn1234) 
    # {
    #   "ending_number" = "4" # last number of suffix
    #   "prefix" = "vnn"
    #   "server_type" = "n" last letter of prefix
    #   "suffix" = "1234"
    # }
    regex("(?i)(?:(?P<prefix>^[[:alpha:]]+(?P<server_type>[[:alpha:]]))(?P<suffix>[[:digit:]]+(?P<ending_number>[[:digit:]]$)))", vm.vm_name)
  }
}