

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

In plain just set value = "xxxx"
In env vars set it in the system like export PKR_VAR_xxxxx = "xxxx"
In vault set in the variable the key value of the object in vault + assign the var.vault_kv_path

The problem with the env its that you can set differents values for the same variable
