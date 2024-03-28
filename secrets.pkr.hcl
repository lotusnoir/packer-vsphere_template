locals {
  vsphere_server     =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/vsphere", var.vsphere_server) : var.vsphere_server
  vsphere_username   =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/vsphere", var.vsphere_username) : var.vsphere_username
  vsphere_password   =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/vsphere", var.vsphere_password) : var.vsphere_password 
  root_password      =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "root_password") : var.root_password
  ssh_username       =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_username") : var.ssh_username
  ssh_password       =  var.secrets_method == "vault" ? vault("${var.vault_kv_path}/ssh", "ssh_password") : var.ssh_password
}
