#----------------------------------------------------------------------------------
# Variable definition file to build the Debian 12 image 
#----------------------------------------------------------------------------------
# https://www.debian.org/download
# https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA512SUMS

### Location Configuration
vm_name = "template-linux-debian-12"

### Create Configuration
guest_os_type = "ubuntu64Guest"
disk_size     = 10240

### ISO Configuration
iso_checksum = "c79e2532fd3cf40b171a7a89a7de8cff37cb333c85870104b72f8e3e2d150f3321a683a556f5fd4ee204dcba288655af7793faa25a6166bf1e31cced4db1611c"
iso_url      = "https://miroir.univ-lorraine.fr/debian-cd/current/amd64/iso-dvd/debian-12.7.0-amd64-DVD-1.iso"
remove_cdrom = true
cd_label = "cidata"
cd_content_filename = "preseed.cfg"
cd_content_filename_path = "../../modules/packer-unattended_distrib_files/linux/debian/preseed_standalone.pkrtpl"
boot_command =  [
  "<esc><wait>install <wait>auto=true priority=critical file=/mnt/cdrom2/preseed.cfg <wait>",
  "netcfg/disable_autoconfig=true ",
  "netcfg/use_autoconfig=false ",
  "netcfg/get_ipaddress=100.64.0.66 ",
  "netcfg/get_netmask=255.255.255.240 ",
  "netcfg/get_gateway=100.64.0.65 ",
  "netcfg/get_nameservers=8.8.8.8 ",
  "netcfg/confirm_static=true <wait>",
  "<wait><enter><wait5>",
  "<leftAltOn><f2><leftAltOff>",
  "<wait><enter><wait>",
  "mkdir /mnt/cdrom2<enter><wait>",
  "mount /dev/sr1 /mnt/cdrom2<enter><wait>",
  "<leftAltOn><f1><leftAltOff><wait>",
  "<enter><wait><enter><wait>",
  "<down><down><down><down><enter>",
]

### provisioning
ansible_groups = ["os_debian12", "groups_packer_build"]
