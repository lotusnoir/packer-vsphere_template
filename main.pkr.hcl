##########################################################
## CLONE PARAMS
##########################################################
source "vsphere-iso" "template" {
  # VCenter Settings
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  host                = var.vsphere_host
  datacenter          = var.vsphere_datacenter
  datastore           = var.vsphere_datastore
  folder              = var.vsphere_folder
  resource_pool       = var.vm_resource_pool
  insecure_connection = var.insecure_connection
  convert_to_template = var.convert_to_template

  ### Misc config
  communicator = var.communicator
  remove_cdrom = var.remove_cdrom
  #cdrom_type            = "ide"
  #firmware              = "efi" #bios
  #usb_controller        = ["usb"]

  ### Iso config
  iso_url         = var.iso_url
  iso_checksum    = var.iso_checksum
  iso_target_path = var.iso_target_path

  # VM Settings
  vm_name         = var.vm_name
  guest_os_type   = var.vm_guest_os
  vm_version      = var.vm_guest_version
  CPUs            = var.vm_cpu
  CPU_hot_plug    = var.vm_cpu_hot_plug
  RAM             = var.vm_memory
  RAM_reserve_all = var.vm_memory_reserve_all
  RAM_hot_plug    = var.vm_memory_hot_plug
  network_adapters {
    network      = var.vm_network
    network_card = var.vm_network_card
  }
  disk_controller_type = ["lsilogic-sas"]
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }

  ### Install config
  boot_order             = var.boot_order
  boot_command           = var.boot_command
  boot_wait              = var.boot_wait
  boot_keygroup_interval = var.boot_keygroup_interval
  http_port_min          = var.http_port_min
  http_port_max          = var.http_port_max
  http_content = {
    "/preseed.cfg" = templatefile(var.os_autoinstall_path, {
      root_password = var.root_password,
      ssh_username  = var.ssh_username,
      ssh_password  = var.ssh_password,
      http_proxy    = var.http_proxy
    })
  }

  ssh_username     = var.ssh_username
  ssh_password     = var.ssh_password
  ssh_timeout      = var.ssh_timeout
  notes            = "Created on ${formatdate("YYYY-MM-DD", timestamp())}"
  shutdown_command = "echo '${var.ssh_password}' | sudo -S -E shutdown -P now"
  shutdown_timeout = "15m"
}


##########################################################
### BUILD
##########################################################
build {
  sources = ["source.vsphere-iso.template"]

  #provisioner "ansible" {
  #  playbook_file    	= "${var.ansible_path}/playbooks/${var.ansible_playbook}"
  #  roles_path       	= "${var.ansible_path}/roles/base"
  #  inventory_directory = "${var.ansible_path}/inventory"
  #  user             	= "${var.ssh_username}"
  #  groups           	= "${var.ansible_groups}"
  #  host_alias          = "${var.vsphere_vm_name}"
  #  #extra_arguments     = [ "--limit=!packer_test"]
  #  ansible_env_vars 	= [
  #    "ANSIBLE_CONFIG=${var.ansible_path}/ansible.cfg",
  #    "ANSIBLE_FORCE_COLOR=1",
  #    "PACKER_BUILD_NAME=${var.vsphere_vm_name}"
  #  ]
  #    #"ansible_ssh_pass=${var.ssh_password}"
  #}
}


##########################################################
### VARIABLES DECLARATION
##########################################################
variable "vsphere_server" {
  type = string
}

variable "vsphere_username" {
  type = string
}

variable "vsphere_password" {
  type      = string
  sensitive = true
}

variable "vsphere_host" {
  type = string
}

variable "vsphere_datastore" {
  type = string
}

variable "vsphere_datacenter" {
  type = string
}

variable "vsphere_folder" {
  type    = string
  default = ""
}

variable "vm_resource_pool" {
  type = string
}

variable "insecure_connection" {
  type    = string
  default = false
}

variable "convert_to_template" {
  type    = bool
  default = true
}

#######################################
variable "communicator" {
  type    = string
  default = "ssh"
}

variable "remove_cdrom" {
  type    = bool
  default = true
}



#######################################
variable "iso_checksum" {
  type    = string
  default = ""
}

variable "iso_url" {
  type    = string
  default = ""
}

variable "iso_target_path" {
  type    = string
  default = ""
}



#######################################
variable "vm_name" {
  type = string
}

variable "vm_guest_os" {
  type = string
}

variable "vm_guest_version" {
  type = string
}

variable "vm_cpu" {
  type    = number
  default = 1
}

variable "vm_cpu_hot_plug" {
  type    = bool
  default = false
}

variable "vm_memory" {
  type    = number
  default = 2048
}

variable "vm_memory_reserve_all" {
  type    = bool
  default = false
}

variable "vm_memory_hot_plug" {
  type    = bool
  default = false
}

variable "vm_network" {
  type = string
}

variable "vm_network_card" {
  type = string
}

variable "disk_size" {
  type    = number
  default = 6144
}
variable "disk_thin_provisioned" {
  type    = bool
  default = false
}




#######################################
variable "boot_order" {
  type    = string
  default = "disk"
}

variable "boot_wait" {
  type    = string
  default = "10s"
}

variable "boot_keygroup_interval" {
  type    = string
  default = "5ms"
}

variable "boot_command" {
  type        = list(string)
  description = "Boot command"
  default     = []
}

variable "http_port_min" {
  type    = number
  default = 8000
}

variable "http_port_max" {
  type    = number
  default = 9000
}

variable "os_autoinstall_path" {
  type = string
}

##########################################
variable "root_password" {
  type      = string
  sensitive = true
}

variable "ssh_password" {
  type      = string
  sensitive = true
}

variable "ssh_username" {
  type    = string
  default = ""
}

variable "ssh_timeout" {
  type    = string
  default = "5m"
}

variable "ssh_key" {
  type    = string
  default = ""
}

variable "cloudinit_userdata" {
  type    = string
  default = ""
}

variable "cloudinit_metadata" {
  type    = string
  default = ""
}

variable "shell_scripts" {
  type        = list(string)
  description = "A list of scripts."
  default     = []
}


#####################################
variable "ansible_playbook" {
  type    = string
  default = "packer.yml"
}

variable "template_net_ip" {
  type = string
}

variable "template_net_dns" {
  type = string
}

variable "template_net_dns2" {
  type = string
}

variable "template_net_gateway" {
  type = string
}

variable "ansible_groups" {
  type    = list(string)
  default = []
}

variable "ansible_path" {
  type = string
}

variable "http_proxy" {
  type = string
}


