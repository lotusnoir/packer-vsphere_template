

### secrets

There is 3 possibility for now

- plain
- env var
- vault

You need to set values for this variables

vsphere_server
vsphere_username
vsphere_password
root_password
ssh_username
ssh_password

#### In plain

just set in your variables.pkrvars.hcl

    value = "xxxx"

#### In Env

Create a executable file containing

    export PKR_VAR_xxxxx = "xxxx"

The problem with the env its that you can set differents values for the same variable

#### In vault

just set in your variables.pkrvars.hcl

    secrets_method = "vault"
    vault_kv_path = "kv/data/terraform"
    vsphere_server = "vsphere_server"

In vault path you need to have the vsphere credentials in a subfolder vsphere and ssh ones in a subfolder ssh
In the variables you dont assign the value but the vaul key tto find the value
