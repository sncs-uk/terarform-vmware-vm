data vsphere_datacenter "datacenter" {
  name = var.datacenter_name
}

data vsphere_compute_cluster "cluster" {
  name          = var.cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data vsphere_datastore "datastore" {
  name          = var.datastore_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data vsphere_network "network" {
  name          = var.network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data vsphere_virtual_machine "template" {
  name          = var.template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.hostname
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  # VM resources #
  num_cpus = var.vCPUs
  memory   = var.memory

  # Guest OS #
  guest_id = data.vsphere_virtual_machine.template.guest_id
  firmware = data.vsphere_virtual_machine.template.firmware
  folder   = var.vm_folder

  # VM storage #
  disk {
    label            = "OS.vmdk"
    size             = data.vsphere_virtual_machine.template.disks[0].size
    thin_provisioned = data.vsphere_virtual_machine.template.disks[0].thin_provisioned
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks[0].eagerly_scrub
  }

  # VM networking #
  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  # Customization of the VM #
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    linked_clone  = "false"
    customize {
      linux_options {
        host_name     = var.hostname
        domain        = var.domain
      }
      network_interface {
        ipv4_address  = var.ipv4_address
        ipv4_netmask  = var.ipv4_netmask
        ipv6_address  = var.ipv6_address
        ipv6_netmask  = var.ipv6_netmask
      }
      ipv4_gateway    = var.ipv4_gateway
      ipv6_gateway    = var.ipv6_gateway
      dns_server_list = var.dns_servers
    }
  }

  provisioner "remote-exec" {
    inline = ["echo 'Hello World'"]
    connection {
      type = "ssh"
      user = var.username
      private_key = var.private_key
      host = "${vsphere_virtual_machine.vm.default_ip_address}"
    }
  }
}
