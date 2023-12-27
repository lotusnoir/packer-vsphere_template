#----------------------------------------------------------------------------------
# Variable definition file to build the Debian 11 image 
#----------------------------------------------------------------------------------
# https://www.debian.org/download
# https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS

### Configuration Reference
convert_to_template = true

### Boot Configuration
boot_command = [
  "<esc><wait>",
  "auto <wait>",
  "netcfg/disable_autoconfig=true ",
  "netcfg/use_autoconfig=false ",
  "netcfg/get_ipaddress=10.4.255.2 ",
  "netcfg/get_netmask=255.255.255.240 ",
  "netcfg/get_gateway=10.4.255.1 ",
  "netcfg/get_nameservers=10.1.80.155 ",
  "netcfg/confirm_static=true <wait>",
  "url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg <wait>",
  "<enter><wait>"
]

### Http directory configuration
http_content_filename      = "preseed.cfg"
http_content_filename_path = "exemples/preseed.pkrtpl"
ssh_username               = "test"
ssh_password               = "strongpass"
root_password              = "strongpass"
net_ip                     = "10.4.255.2"
net_gateway                = "10.4.255.1"
net_netmask                = "255.255.255.240"
net_dns                    = "10.1.80.155"
timezone                   = "Europe/Paris"
keyboard_layout            = "fr"
http_proxy                 = "http://10.1.80.5:80"
http_port_min              = 8080
http_port_max              = 8080

### Connection Configuration
vsphere_server     = "10.1.1.1"
vsphere_username   = "test"
vsphere_password   = "test"
insecure_connection = true
vsphere_datacenter  = "MyDC"

### Hardware Configuration
cpu    = 2
memory = 4096

### Location Configuration
vm_name           = "test-tpl-packer"
vsphere_folder    = "Templates"
vsphere_host      = "VxRail-Cluster"
resource_pool     = "mypool"
vsphere_datastore = "VxRail-Virtual-SAN"

### ISO Configuration
iso_checksum = "4460ef6470f6d8ae193c268e213d33a6a5a0da90c2d30c1024784faa4e4473f0c9b546a41e2d34c43fbbd43542ae4fb93cfd5cb6ac9b88a476f1a6877c478674"
iso_url      = "https://cdimage.debian.org/mirror/cdimage/archive/11.7.0/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"

### Create Configuration
guest_os_version      = "19"
guest_os_type         = "ubuntu64Guest"
vm_network            = "templates"
disk_size             = 7168
disk_thin_provisioned = true

### Provisionning Ansible
ansible_path   = "exemples/ansible"
ansible_groups = ["pau", "os_debian11", "groups_packer_build"]
