#----------------------------------------------------------------------------------
# Variable definition file to build the Debian 11 image 
#----------------------------------------------------------------------------------
# https://www.debian.org/download
# https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS


### Vsphere variables
vsphere_server          = "10.1.1.1" 
vsphere_username        = "test"
vsphere_password        = "secure pawd"
vsphere_host            = "VxRail-Cluster"             #cluster
vsphere_datacenter      = "MyDC"
vsphere_datastore       = "VxRail-Virtual-SAN-Datastore"
vsphere_folder          = "Templates"
vm_resource_pool        = "testpool"
insecure_connection     = true
convert_to_template     = true


### Misc variables
#communicator = "ssh"
#remove_cdrom = true
#cdrom_type            = "ide"
#firmware              = "bios"
#usb_controller        = ["usb"]


### Iso variables
iso_url = "https://cdimage.debian.org/mirror/cdimage/archive/11.7.0/amd64/iso-cd/debian-11.7.0-amd64-netinst.iso"
iso_checksum = "4460ef6470f6d8ae193c268e213d33a6a5a0da90c2d30c1024784faa4e4473f0c9b546a41e2d34c43fbbd43542ae4fb93cfd5cb6ac9b88a476f1a6877c478674"
#iso_target_path	    = "/data/packer"


### VM variables
vm_name = "template-linux-debian-11"
guest_os_type = "ubuntu64Guest"
guest_os_version = "19"
cpu = 2
cpu_hot_plug = true
memory = 4096
memory_reserve_all = true
memory_hot_plug = true
vm_network = "templates"
vm_network_card = "vmxnet3"
disk_size = 7168
disk_thin_provisioned = true

### Boot command
autoinstall_file_path = "exemples/preseed.pkrtpl"
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
#ssh settings
ssh_username            = "set in env var"
ssh_password            = "set in env var"
root_password           = "set in env var"
ssh_timeout = "5m"

net_ip = "10.4.255.2"
net_dns        = "10.1.80.155"
net_gateway    = "10.4.255.1"
http_proxy          = "http://10.1.80.5:80"

### Provisionning Ansible
ansible_path		= "exemples/ansible"
ansible_groups = ["pau", "os_debian11", "groups_packer_build"]
