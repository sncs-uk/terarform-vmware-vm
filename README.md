# VMware VM

This module creates a VM from a template, using cloud-init to customise the settings. It abstracts all the data objects away so there is just one resource to configure.

Disk sizes are in GB

## Usage

```hcl
module "example" {
  source            = "github.com/sncs-uk/terraform-vmware-vm"
  hostname          = "vm-example"
  template_name     = "my-super-template"
  network_name      = "VM Network"
  ipv4_addresses    = "10.20.30.40/24"
  ipv4_gateway      = "10.20.30.1"
  ipv6_addresses    = "2001:0db8::2/64"
  ipv6_gateway      = "2001:0db8::1"
  nameservers       = ["1.1.1.1", "8.8.8.8"]
  username          = "debian"
  ssh_keys          = ["ssh-rsa Azusjdif..."]
  vCPUs             = 2
  memory            = 2048
  datacenter_name   = "DC"
  cluster_name      = "Cluster"
  datastore_name    = "vSanDatastore"
  vm_folder         = "My folder"
  disk_size         = 10
  thin_provision    = true
  additional_disks  = [
    {
      label            = "disk-1"
      size             = 10
      thin_provisioned = true
      eagerly_scrub    = false
    }
  ]
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vsphere"></a> [vsphere](#provider\_vsphere) | >= 2.4.1 |
