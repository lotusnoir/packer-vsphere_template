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
  http_content   = var.http_content_filename == "" ? {} : merge({
    "/${var.http_content_filename}" = templatefile(var.http_content_filename_path, {
      internet_install  = var.internet_install
      root_password   = local.root_password
      ssh_username    = local.ssh_username
      ssh_password    = var.cd_content_filename == "user-data" ? bcrypt("${local.ssh_password}") : local.ssh_password
      net_ip          = var.net_ip
      net_gateway     = var.net_gateway
      net_netmask     = var.net_netmask
      net_dns         = var.net_dns
      timezone        = var.timezone
      locales         = var.locales
      keyboard_layout = var.keyboard_layout
      disk_swap_size  = var.disk_swap_size
      disk_boot_size  = var.disk_boot_size
      http_proxy      = var.http_proxy
    })
  }, var.http_content_extra)
  http_port_min     = var.http_port_min
  http_port_max     = var.http_port_max
  http_bind_address = var.http_bind_address

  ### Floppy configuration
  floppy_img_path = var.floppy_img_path
  floppy_files    = var.floppy_files
  floppy_dirs     = var.floppy_dirs
  floppy_content   = var.floppy_content_filename == "" ? {} : merge({
    "/${var.floppy_content_filename}" = templatefile(var.floppy_content_filename_path, {
      internet_install  = var.internet_install
      root_password   = local.root_password
      ssh_username    = local.ssh_username
      ssh_password    = var.cd_content_filename == "user-data" ? bcrypt("${local.ssh_password}") : local.ssh_password
      net_ip          = var.net_ip
      net_gateway     = var.net_gateway
      net_netmask     = var.net_netmask
      net_dns         = var.net_dns
      timezone        = var.timezone
      locales         = var.locales
      keyboard_layout = var.keyboard_layout
      disk_swap_size  = var.disk_swap_size
      disk_boot_size  = var.disk_boot_size
      http_proxy      = var.http_proxy
    })
  }, var.floppy_content_extra)
  floppy_label    = var.floppy_label

  ### Connection Configuration
  vcenter_server      = local.vsphere_server
  username            = local.vsphere_username
  password            = local.vsphere_password
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
  resource_pool                  = var.resource_pool
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
  cd_content   = var.cd_content_filename == "" ? {} : merge({
    "/${var.cd_content_filename}" = templatefile(var.cd_content_filename_path, {
      internet_install  = var.internet_install
      root_password   = local.root_password
      ssh_username    = local.ssh_username
      ssh_password    = var.cd_content_filename == "user-data" ? bcrypt("${local.ssh_password}") : local.ssh_password
      net_ip          = var.net_ip
      net_gateway     = var.net_gateway
      net_netmask     = var.net_netmask
      net_dns         = var.net_dns
      timezone        = var.timezone
      locales         = var.locales
      keyboard_layout = var.keyboard_layout
      disk_swap_size  = var.disk_swap_size
      disk_boot_size  = var.disk_boot_size
      http_proxy      = var.http_proxy
    })
  }, var.cd_content_extra)
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
  ssh_username                 = local.ssh_username
  ssh_password                 = local.ssh_password
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
    user                = "${local.ssh_username}"
    groups              = "${var.ansible_groups}"
    host_alias          = "${var.vm_name}"
    extra_arguments     = [ "--extra-vars", "ansible_ssh_pass=${local.ssh_password}", "--scp-extra-args", "'-O'"]
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False",
      "ANSIBLE_CONFIG=${var.ansible_path}/ansible.cfg",
      "ANSIBLE_FORCE_COLOR=1",
      "PACKER_BUILD_NAME=${var.vm_name}"
    ]
  }
}
