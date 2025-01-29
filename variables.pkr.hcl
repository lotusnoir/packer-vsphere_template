##########################################################
### VARIABLES DECLARATION
##########################################################
### Configuration Reference
variable "convert_to_template" {
  type    = bool
  default = false
}

variable "secrets_method" {
  type    = string
  default = "plain" #or vault
}

variable "vault_kv_path" {
  type    = string
  default = ""
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
variable "internet_install" {
  type    = bool
  default = true
}
variable "http_content_filename" {
  type    = string
  default = ""
}
variable "http_content_filename_path" {
  type    = string
  default = ""
}
variable "http_content_extra" {
  type    = map(string)
  default = {}
}
variable "root_password" {
  type      = string
  sensitive = true
  default   = null
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
  default = "Europe/Paris"
}
variable "locales" {
  type    = string
  default = "en_US.UTF-8"
}
variable "keyboard_layout" {
  type    = string
  default = "us"
}
variable "disk_swap_size" {
  type    = string
  default = "1024"
}
variable "disk_boot_size" {
  type    = string
  default = "640"
}
variable "http_proxy" {
  description = "If internet install, do you need to set a proxy ? default means no proxy"
  type        = string
  default     = ""
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
variable "floppy_label" {
  description = "The label to use for the floppy disk that is attached when the VM is booted. This is most useful for cloud-init, Kickstart or other early initialization tools, which can benefit from labelled floppy disks."
  type        = string
  default     = "packer"
}
variable "floppy_content_filename" {
  type    = string
  default = ""
}
variable "floppy_content_filename_path" {
  type    = string
  default = ""
}
variable "floppy_content_extra" {
  type    = map(string)
  default = {}
}


#############################################################
### Connection Configuration
variable "vsphere_server" {
  description = "vCenter Server hostname"
  type        = string
  default     = null
}
variable "vsphere_username" {
  description = "vCenter username"
  type        = string
  default     = null
}
variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
  default     = null
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
variable "resource_pool" {
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
variable "cd_content_extra" {
  type    = map(string)
  default = {}
}
variable "cd_label" {
  type    = string
  default = null
}
variable "cd_content_filename" {
  type    = string
  default = ""
}
variable "cd_content_filename_path" {
  type    = string
  default = ""
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
  default     = "vmxnet3"
}
variable "usb_controller" {
  description = ""
  type        = list(string)
  default     = null
}
#variable "notes" {
#  type    = string
#  default = null
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
  default     = "packer"
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


variable "winrm_username" {
  type        = string
  description = "The username to use to connect to WinRM."
  default     = "Administrateur"
}

variable "winrm_password" {
  type        = string
  description = "The password to use to connect to WinRM."
  default     = null
}

variable "winrm_host" {
  type        = string
  description = "The address for WinRM to connect to."
  default     = null
}

variable "winrm_no_proxy" {
  type        = bool
  description = "Setting this to true adds the remote host:port to the NO_PROXY environment variable. This has the effect of bypassing any configured proxies when connecting to the remote host."
  default     = false
}

variable "winrm_port" {
  type        = string
  description = "The WinRM port to connect to. This defaults to 5985 for plain unencrypted connection and 5986 for SSL when winrm_use_ssl is set to true."
  default     = "5985"
}

variable "winrm_timeout" {
  type        = string
  description = "The amount of time to wait for WinRM to become available. This defaults to 30m since setting up a Windows machine generally takes a long time."
  default     = "15m"
}

variable "winrm_use_ssl" {
  type        = bool
  description = "If true, use HTTPS for WinRM."
  default     = false
}

variable "winrm_insecure" {
  type        = bool
  description = "If true, do not check server certificate chain and host name."
  default     = false
}

variable "winrm_use_ntlm" {
  type        = bool
  description = "If true, NTLMv2 authentication (with session security) will be used for WinRM, rather than default (basic authentication), removing the requirement for basic authentication to be enabled within the target guest. Further reading for remote connection authentication can be found here."
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
  type        = list(string)
  default     = []
}

variable "ansible_path" {
  description = ""
  type        = string
}
