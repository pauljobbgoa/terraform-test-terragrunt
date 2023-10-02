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
  generated_password = {
    for vm in var.vm : vm.vm_name =>
      #regex that creates 2 capture groups, 1st is the first character of the password and the 2nd the rest of the password string.
      #the ending number of the vm is then inserted n between them i.e.
      #PassW0rd becomes P4assW0rd if the the vm name is vnn1234
      replace(local.local_adminpass,"/(^.{1})(.+)/",format("%s%s%s","$${1}",local.server_name_detail[vm.vm_name].ending_number,"$${2}"))
  }
}