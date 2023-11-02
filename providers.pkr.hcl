#packer {                                                                                                 
#  required_version = ">= 1.8.0"
#  required_plugins {
#    vsphere = {
#      version = ">= 1.0.6"
#    }
#  }
#  required_plugins{
#    windows-update = {
#      version =">= 0.14.3"
#    }
#  }
#}


packer {
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = "~> 1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}

