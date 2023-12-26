##########################################################
## CLONE PARAMS
##########################################################
source "vsphere-iso" "this" {
  ### Configuration Reference
  convert_to_template = var.convert_to_template

  ### Boot Configuration
  boot_keygroup_interval = var.boot_keygroup_interval
  boot_wait              = var.boot_wait
  boot_command           = var.boot_command
  http_ip                = var.http_ip

  ### Http directory configuration
  http_directory = var.http_directory
  http_content = {
    "/${var.boot_filename}" = templatefile(var.autoinstall_file_path, {
      root_password   = var.root_password,
      ssh_username    = var.ssh_username,
      ssh_password    = var.ssh_password,
      net_ip          = var.net_ip,
      net_gateway     = var.net_gateway,
      net_netmask     = var.net_netmask,
      net_dns         = var.net_dns,
      timezone        = var.timezone,
      locales         = var.locales,
      keyboard_layout = var.keyboard_layout,
      disk_swap_size  = var.disk_swap_size,
      disk_boot_size  = var.disk_boot_size,
      http_proxy      = var.http_proxy

    })
  }
  http_port_min     = var.http_port_min
  http_port_max     = var.http_port_max
  http_bind_address = var.http_bind_address

  ### Floppy configuration
  floppy_img_path = var.floppy_img_path
  floppy_files    = var.floppy_files
  floppy_dirs     = var.floppy_dirs
  floppy_content  = var.floppy_content
  floppy_label    = var.floppy_label

  ### Connection Configuration
  vcenter_server      = var.vsphere_server
  username            = var.vsphere_username
  password            = var.vsphere_password
  insecure_connection = var.insecure_connection
  datacenter          = var.vsphere_datacenter

  ### Hardware Configuration
  CPUs             = var.cpu
  cpu_cores        = var.cpu_cores
  CPU_reservation  = var.cpu_reservation
  CPU_limit        = var.cpu_limit
  CPU_hot_plug     = var.cpu_hot_plug
  RAM              = var.memory
  RAM_reservation  = var.memory_reservation
  RAM_reserve_all  = var.memory_reserve_all
  RAM_hot_plug     = var.memory_hot_plug
  video_ram        = var.video_ram
  displays         = var.displays
  vgpu_profile     = var.vgpu_profile
  NestedHV         = var.nestedhv
  firmware         = var.firmware
  force_bios_setup = var.force_bios_setup
  vTPM             = var.vtpm

  ### Location Configuration
  vm_name                        = var.vm_name
  folder                         = var.vsphere_folder
  cluster                        = var.vsphere_cluster
  host                           = var.vsphere_host
  resource_pool                  = var.vm_resource_pool
  datastore                      = var.vsphere_datastore
  set_host_for_datastore_uploads = var.set_host_for_datastore_uploads

  ### Run Configuration
  boot_order = var.boot_order

  ### Shutdown Configuration
  shutdown_command = var.shutdown_command
  shutdown_timeout = var.shutdown_timeout
  disable_shutdown = var.disable_shutdown


  ### Wait Configuration
  ip_wait_timeout   = var.ip_wait_timeout
  ip_settle_timeout = var.ip_settle_timeout
  ip_wait_address   = var.ip_wait_address


  ### ISO Configuration
  iso_checksum         = var.iso_checksum
  iso_url              = var.iso_url
  iso_target_path      = var.iso_target_path
  iso_target_extension = var.iso_target_extension


  ### CDRom Configuration
  cdrom_type   = var.cdrom_type
  iso_paths    = var.iso_paths
  remove_cdrom = var.remove_cdrom
  cd_files     = var.cd_files
  cd_content   = var.cd_content
  cd_label     = var.cd_label


  ### Create Configuration
  vm_version    = var.guest_os_version
  guest_os_type = var.guest_os_type
  network_adapters {
    network      = var.vm_network
    network_card = var.vm_network_card
  }
  usb_controller       = var.usb_controller
  notes                = "Created on ${formatdate("YYYY-MM-DD", timestamp())}"
  destroy              = var.destroy
  disk_controller_type = [var.disk_controller_type]
  storage {
    disk_size             = var.disk_size
    disk_thin_provisioned = var.disk_thin_provisioned
  }


  ### Network Adapter Configuration


  ### Storage Configuration


  ### Communicator configuration
  communicator                 = var.communicator
  pause_before_connecting      = var.pause_before_connecting
  ssh_host                     = var.ssh_host
  ssh_port                     = var.ssh_port
  ssh_username                 = var.ssh_username
  ssh_password                 = var.ssh_password
  ssh_ciphers                  = var.ssh_ciphers
  ssh_clear_authorized_keys    = var.ssh_clear_authorized_keys
  ssh_key_exchange_algorithms  = var.ssh_key_exchange_algorithms
  ssh_certificate_file         = var.ssh_certificate_file
  ssh_pty                      = var.ssh_pty
  ssh_timeout                  = var.ssh_timeout
  ssh_disable_agent_forwarding = var.ssh_disable_agent_forwarding
  ssh_handshake_attempts       = var.ssh_handshake_attempts
  ssh_bastion_host             = var.ssh_bastion_host
  ssh_bastion_port             = var.ssh_bastion_port
  ssh_bastion_agent_auth       = var.ssh_bastion_agent_auth
  ssh_bastion_username         = var.ssh_bastion_username
  ssh_bastion_password         = var.ssh_bastion_password
  ssh_bastion_interactive      = var.ssh_bastion_interactive

}


##########################################################
### BUILD
##########################################################
build {
  sources = ["source.vsphere-iso.this"]

  provisioner "ansible" {
    playbook_file       = "${var.ansible_path}/playbooks/${var.ansible_playbook}"
    roles_path          = "${var.ansible_path}/roles/base"
    inventory_directory = "${var.ansible_path}/inventory"
    user                = "${var.ssh_username}"
    groups              = "${var.ansible_groups}"
    host_alias          = "${var.vm_name}"
    #extra_arguments     = [ "--limit=!packer_test"]
    ansible_env_vars = [
      "ANSIBLE_CONFIG=${var.ansible_path}/ansible.cfg",
      "ANSIBLE_FORCE_COLOR=1",
      "PACKER_BUILD_NAME=${var.vm_name}"
    ]
    #"ansible_ssh_pass=${var.ssh_password}"
  }
}


##########################################################
### VARIABLES DECLARATION
##########################################################
### Configuration Reference
variable "convert_to_template" {
  type    = bool
  default = false
}

##########################################################
### Boot Configuration
variable "boot_keygroup_interval" {
  description = "Time to wait after sending a group of key pressses. The value of this should be a duration"
  type        = string
  default     = "5ms"
}
variable "boot_wait" {
  description = "The time to wait after booting the initial virtual machine before typing the boot_command. The value of this should be a duration."
  type        = string
  default     = "10s"
}
variable "boot_command" {
  description = "This is an array of commands to type when the virtual machine is first booted. The goal of these commands should be to type just enough to initialize the operating system installer. Special keys can be typed as well, and are covered in the section below on the boot command. If this is not specified, it is assumed the installer will start itself."
  type        = list(string)
  default     = []
}
variable "http_ip" {
  description = "The IP address to use for the HTTP server started to serve the http_directory."
  type        = string
  default     = null
}


#############################################################
### Http directory configuration
variable "http_directory" {
  description = " Path to a directory to serve using an HTTP server. The files in this directory will be available over HTTP that will be requestable from the virtual machine. This is useful for hosting kickstart files and so on."
  type        = string
  default     = ""
}
########################
#variable "http_content"
variable "boot_filename" {
  type    = string
  default = "preseed.cfg"
}
variable "autoinstall_file_path" {
  type    = string
}
variable "root_password" {
  type      = string
  sensitive = true
}
variable "net_ip" {
  type    = string
  default = null
}
variable "net_gateway" {
  type    = string
  default = null
}
variable "net_netmask" {
  type    = string
  default = null
}
variable "net_dns" {
  description = ""
  type        = string
  default     = null
}
variable "timezone" {
  type    = string
  default = null
}
variable "locales" {
  type    = string
  default = null
}
variable "keyboard_layout" {
  type    = string
  default = null
}
variable "disk_swap_size" {
  type    = string
  default = null
}
variable "disk_boot_size" {
  type    = string
  default = null
}
variable "http_proxy" {
  description = ""
  type        = string
  default     = null
}
########################
variable "http_port_min" {
  description = "These are the minimum and maximum port to use for the HTTP server started to serve the http_directory. Because Packer often runs in parallel, Packer will choose a randomly available port in this range to run the HTTP server. If you want to force the HTTP server to be on one port, make this minimum and maximum port the same. "
  type        = number
  default     = 8000
}
variable "http_port_max" {
  description = "HTTP Port Max"
  type        = number
  default     = 9000
}
variable "http_bind_address" {
  description = "This is the bind address for the HTTP server."
  type        = string
  default     = "0.0.0.0"
}


#############################################################
### Floppy configuration
variable "floppy_img_path" {
  description = "Datastore path to a floppy image that will be mounted to the VM. "
  type        = string
  default     = null
}
variable "floppy_files" {
  description = "List of local files to be mounted to the VM floppy drive. Can be used to make Debian preseed or RHEL kickstart files available to the VM."
  type        = list(string)
  default     = null
}
variable "floppy_dirs" {
  description = " List of directories to copy files from."
  type        = list(string)
  default     = null
}
variable "floppy_content" {
  description = "Key/Values to add to the floppy disk. The keys represent the paths, and the values contents. It can be used alongside floppy_files or floppy_dirs, which is useful to add large files without loading them into memory."
  type        = map(string)
  default     = {}
}
variable "floppy_label" {
  description = "The label to use for the floppy disk that is attached when the VM is booted. This is most useful for cloud-init, Kickstart or other early initialization tools, which can benefit from labelled floppy disks."
  type        = string
  default     = "packer"
}


#############################################################
### Connection Configuration
variable "vsphere_server" {
  description = "vCenter Server hostname"
  type        = string
}
variable "vsphere_username" {
  description = "vCenter username"
  type        = string
}
variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}
variable "insecure_connection" {
  description = "Do not validate the vCenter Server TLS certificate"
  type        = string
  default     = false
}
variable "vsphere_datacenter" {
  description = "vSphere datacenter name. Required if there is more than one datacenter in the vSphere inventory."
  type        = string
}


#############################################################
### Hardware Configuration
variable "cpu" {
  description = "Number of CPU cores."
  type        = number
  default     = 1
}
variable "cpu_cores" {
  description = "Number of CPU cores per socket."
  type        = number
  default     = 1
}
variable "cpu_reservation" {
  description = "Amount of reserved CPU resources in MHz."
  type        = number
  default     = null
}
variable "cpu_limit" {
  description = " Upper limit of available CPU resources in MHz."
  type        = number
  default     = null
}
variable "cpu_hot_plug" {
  description = "Enable CPU hot plug setting for virtual machine."
  type        = bool
  default     = false
}
variable "memory" {
  description = "Amount of RAM in MB."
  type        = number
  default     = 2048
}
variable "memory_reservation" {
  description = "Amount of reserved RAM in MB."
  type        = number
  default     = null
}
variable "memory_reserve_all" {
  description = "Reserve all available RAM."
  type        = bool
  default     = false
}
variable "memory_hot_plug" {
  description = "Enable RAM hot plug setting for virtual machine."
  type        = bool
  default     = false
}
variable "video_ram" {
  description = "Amount of video memory in KB. See vSphere documentation for supported maximums. "
  type        = number
  default     = 4096
}
variable "displays" {
  description = "Number of video displays. See vSphere documentation for supported maximums."
  type        = number
  default     = 1
}
variable "vgpu_profile" {
  description = "vGPU profile for accelerated graphics"
  type        = string
  default     = null
}
variable "nestedhv" {
  description = "Enable nested hardware virtualization for VM. "
  type        = bool
  default     = false
}
variable "firmware" {
  description = "Set the Firmware for virtual machine. Supported values: bios, efi or efi-secure."
  type        = string
  default     = "bios"
}
variable "force_bios_setup" {
  description = "During the boot, force entry into the BIOS setup screen. "
  type        = bool
  default     = false
}
variable "vtpm" {
  description = "Add virtual TPM device for virtual machine."
  type        = bool
  default     = false
}


#############################################################
### Location Configuration
variable "vm_name" {
  description = "Name of the new VM to create."
  type        = string
}
variable "vsphere_folder" {
  description = "VM folder to create the VM in."
  type        = string
  default     = ""
}
variable "vsphere_cluster" {
  description = "vSphere cluster where target VM is created"
  type        = string
  default     = null
}
variable "vsphere_host" {
  description = " ESXi host where target VM is created. A full path must be specified if the host is in a folder. "
  type        = string
}
variable "vm_resource_pool" {
  description = " vSphere resource pool. If not set, it will look for the root resource pool of the host or cluster. If a root resource is not found, it will then look for a default resource pool."
  type        = string
}
variable "vsphere_datastore" {
  description = " vSphere datastore. Required if host is a cluster, or if host has multiple datastores."
  type        = string
}
variable "set_host_for_datastore_uploads" {
  description = " Set this to true if packer should use the host for uploading files to the datastore."
  type        = bool
  default     = false
}

### Run Configuration
variable "boot_order" {
  description = "Priority of boot devices. "
  type        = string
  default     = "disk,cdrom"
}

### Shutdown Configuration
variable "shutdown_command" {
  description = "Specify a VM guest shutdown command. This command will be executed using the communicator. Otherwise, the VMware Tools are used to gracefully shutdown the VM."
  type        = string
  default     = null
}
variable "shutdown_timeout" {
  description = "Amount of time to wait for graceful VM shutdown. "
  type        = string
  default     = "5m"
}
variable "disable_shutdown" {
  description = "Packer normally halts the virtual machine after all provisioners have run when no shutdown_command is defined."
  type        = bool
  default     = false
}

### Wait Configuration
variable "ip_wait_timeout" {
  type    = string
  default = "30m"
}
variable "ip_settle_timeout" {
  type    = string
  default = "5s"
}
variable "ip_wait_address" {
  type    = string
  default = "0.0.0.0/0"
}

### ISO Configuration
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
  default = null
}
variable "iso_target_extension" {
  type    = string
  default = "iso"
}

### CDRom Configuration
variable "cdrom_type" {
  type    = string
  default = "ide"
}
variable "iso_paths" {
  type    = list(string)
  default = []
}
variable "remove_cdrom" {
  type    = bool
  default = false
}
variable "cd_files" {
  type    = list(string)
  default = []
}
variable "cd_content" {
  type    = map(string)
  default = {}
}
variable "cd_label" {
  type    = string
  default = null
}


### Create Configuration
variable "guest_os_version" {
  type = string
}
variable "guest_os_type" {
  type    = string
  default = "otherGuest"
}
variable "vm_network" {
  description = ""
  type        = string
}
variable "vm_network_card" {
  description = ""
  type        = string
}
variable "usb_controller" {
  description = ""
  type        = list(string)
  default     = null
}
#variable "notes" {
#  description = ""
#  type        = string
#  #default     = "Created on ${formatdate("YYYY-MM-DD", timestamp())}"
#}
variable "destroy" {
  description = ""
  type        = bool
  default     = false
}
variable "disk_controller_type" {
  type    = string
  default = "lsilogic-sas"
}
variable "disk_size" {
  description = ""
  type        = number
  default     = 6144
}
variable "disk_thin_provisioned" {
  description = ""
  type        = bool
  default     = false
}

### Network Adapter Configuration


### Storage Configuration


### Communicator configuration
variable "communicator" {
  type    = string
  default = "ssh"
}
variable "pause_before_connecting" {
  description = "We recommend that you enable SSH or WinRM as the very last step in your guest's bootstrap script, but sometimes you may have a race condition where you need Packer to wait before attempting to connect to your guest."
  type        = string
  default     = null
}
variable "ssh_host" {
  description = "The address to SSH to. This usually is automatically configured by the builder."
  type        = string
  default     = ""
}
variable "ssh_port" {
  description = "The port to connect to SSH."
  type        = string
  default     = "22"
}
variable "ssh_username" {
  description = "The username to connect to SSH with. Required if using SSH."
  type        = string
  default     = ""
}
variable "ssh_password" {
  description = "A plaintext password to use to authenticate with SSH."
  type        = string
  sensitive   = true
  default     = ""
}
variable "ssh_ciphers" {
  description = "This overrides the value of ciphers supported by default by Golang."
  type        = list(string)
  default     = ["aes128-gcm@openssh.com", "chacha20-poly1305@openssh.com", "aes128-ctr", "aes192-ctr", "aes256-ctr", ]
}
variable "ssh_clear_authorized_keys" {
  description = ""
  type        = bool
  default     = false
}
variable "ssh_key_exchange_algorithms" {
  description = "If set, Packer will override the value of key exchange (kex) algorithms supported by default by Golang."
  type        = list(string)
  default     = []
}
variable "ssh_certificate_file" {
  description = "Path to user certificate used to authenticate with bastion host. The ~ can be used in path and will be expanded to the home directory of current user"
  type        = string
  default     = ""
}
variable "ssh_pty" {
  description = "If true, a PTY will be requested for the SSH connection."
  type        = bool
  default     = false
}
variable "ssh_timeout" {
  description = "The time to wait for SSH to become available. Packer uses this to determine when the machine has booted so this is usually quite long. "
  type        = string
  default     = "5m"
}
variable "ssh_disable_agent_forwarding" {
  description = " If true, SSH agent forwarding will be disabled"
  type        = bool
  default     = false
}
variable "ssh_handshake_attempts" {
  description = "The number of handshakes to attempt with SSH once it can connect. "
  type        = number
  default     = 10
}
variable "ssh_bastion_host" {
  description = " A bastion host to use for the actual SSH connection."
  type        = string
  default     = ""
}
variable "ssh_bastion_port" {
  description = "The port of the bastion host."
  type        = number
  default     = "22"
}
variable "ssh_bastion_agent_auth" {
  description = ""
  type        = bool
  default     = false
}
variable "ssh_bastion_username" {
  description = ""
  type        = string
  default     = ""
}
variable "ssh_bastion_password" {
  description = ""
  type        = string
  sensitive   = true
  default     = ""
}
variable "ssh_bastion_interactive" {
  description = ""
  type        = bool
  default     = false
}




##########################
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

variable "ansible_playbook" {
  type    = string
  default = "packer.yml"
}
variable "ansible_groups" {
  description = ""
  type    = list(string)
  default = []
}

variable "ansible_path" {
  description = ""
  type = string
}
