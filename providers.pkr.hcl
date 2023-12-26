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
    windows-update = {
      source = "github.com/rgl/windows-update"
      version = ">= 0.14.3"
    }
  }
}

