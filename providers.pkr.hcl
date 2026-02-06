packer {
  required_version = ">= 1.7.0"
  required_plugins {
    vsphere = {
      source  = "github.com/hashicorp/vsphere"
      version = ">= 2.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.3"
    }
    windows-update = {
      source  = "github.com/rgl/windows-update"
      version = ">= 0.17.1"
    }
  }
}
