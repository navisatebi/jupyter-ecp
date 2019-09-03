# Cloud Portal Application - bioexcel-jupyter
Cloud Portal Bioexcel application to create VM with jupyter.
It uses the ubuntu 18.04 image from openstack and installs conda, jupyter using ansible.

---

## Requirements


## Instructions

## Default values

### `Deployment parameters`

| Parameter name          | Parameter value       |
| ---                     | ---                   |
| `remote_user`           | `ubuntu`              |
| `machine_type`          | `s1.large`            |
| `floating_ip_pool`      | `ext-net-37`          |
| `ssh_key`               | `users's pub key`     |
| `public_key_path`       | `~/.ssh/id_rsa.pub`   |
| `private_key_path`      | `~/.ssh/id_rsa`       |

### `Inputs`

| Parameter name          | Parameter value       |
| ---                     | ---                   |
| `disk_image_name`       | `ubuntu-18.04`        |

### Open Ports
The virtual machine provided will have this ports open.

`ICMP`: `all`  
`TCP` : `22`

