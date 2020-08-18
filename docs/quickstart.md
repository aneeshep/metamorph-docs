## QuickStart

Gettinng started with Metamorph (Standalone) <!-- omit in toc -->

## Contents <!-- omit in toc -->

<!-- Below is generated using VSCode yzhang.markdown-all-in-one >
- [QuickStart](#quickstart)
- [Prerequisites](#prerequisites)
  - [Requirements](#requirements)
- [Setting up OS in a Remote Baremetal host.](#setting-up-os-in-a-remote-baremetal-host)
- [Troubleshooting](#troubleshooting)
<!-- TOC depthFrom:2 -->

- [QuickStart](#quickstart)
- [Prerequisites](#prerequisites)
  - [Requirements](#requirements)
- [Setting up OS in a Remote Baremetal host.](#setting-up-os-in-a-remote-baremetal-host)
- [Troubleshooting](#troubleshooting)

<!-- /TOC -->

## Prerequisites

### Requirements
- Metamorph installation done.
- Metamorph Controller running
- Metamorph API server running
- Web Server hosting ISO running on the port specified in Metamorph config.yaml file
- Any REST client (ex Postman)
- Baremetal Host with known IPMI IP/Username/password

## Setting up OS in a Remote Baremetal host. 


Metamorph API server could be made to run the following steps  to install OS using REST API calls.
Any deviation in the steps below may lead to OS not being successfully installed.

  1. Create the Node object within Metamorph using the followng body in a `POST` message

  URL : `http://<Metamorph API Server>:8080/node`
  Body :
```json
  {
    "name": "<HostName>",
    "IPMIUser": "<IPMIUser>",
    "IPMIPassword": "<IPMIPassword>",
    "IPMIIP": "<IPMIIP>"
  }
```
  2. Update the Node information using `PUT` message.

  URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`

  Example 
  
  Body:
  ```json
{
    "Domain": "vt.xyz.com",
    "ISOURL": "http://x.y.z.a:31180/ubuntu-18.04.4-server-amd64.iso",
    "ISOChecksum": "http://x.y.z.a:31180/ubuntu-18.04.4-server-amd64.iso.md5sum",
    "OsDisk": "/dev/sda",
    "Partitions": [
        {
            "partitionName": "root",
            "size": "30g",
            "filesystem": {
                "mountpoint": "/",
                "fstype": "ext4",
                "mount-options": "defaults"
            }
        },
        {
            "name": "boot",
            "size": "1g",
            "bootable": true,
            "primary": true,
            "filesystem": {
                "mountpoint": "/boot",
                "fstype": "ext4",
                "mount-options": "defaults"
            }
        },
        {
            "name": "var-log",
            "size": "100g",
            "filesystem": {
                "mountpoint": "/var/log",
                "fstype": "ext4",
                "mount-options": "defaults"
            }
        },
        {
            "name": "var",
            "size": ">300g",
            "filesystem": {
                "mountpoint": "/var",
                "fstype": "ext4",
                "mount-options": "defaults"
            }
        }
    ],
    "grubConfig": "image=bionic isolcpus=0-3,44-47 amd_iommu=on kernel_package=linux-image-5.0.0-23-generic kernel=hwe-18.04 hugepagesz=1G hugepages=160 intel_iommu=on console=ttyS1,115200n8 transparent_hugepage=never",
    "kvmPolicy": {
        "cpuAllocation": "1:1",
        "cpuPinning": "enabled",
        "cpuHyperthreading": "enabled"
    }
    ......
    ......
}

  ```

  3. Check the state of the Node Object at this state using the following `GET` message

      URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`

     The node should be in `READYWAIT` state.

  4.  Change the state of  the node to `READY` state using the following `PUT` message.

      URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`
      
      Body:
      ```json
        {
	        "State" : "ready"
        }
      ```
  5. Check the state of the Node Object at this state using the following `GET` message

      URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`

      The node should be in `SETUPREADYWAIT` state.

  6.  Change the state of  the node to `SETUPREADY` state using the following `PUT` message.

      URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`
      
      Body:
      ```json
        {
	        "State" : "setupready"
        }
      ```
  7. On successful update, the ISO installation on the said node will get initiated with preliminary firmware upgrade/RAID configuration started if requested. 

  8. On successfull completion, the node state should be set to deployed. 
 
      Check the state of the Node Object at this state using the following `GET` message

      URL : `http://<Metamorph API Server>:8080/node/<node_uuid>`

      The node should be in `DEPLOYED` state.


## Troubleshooting

Please refer to the [troubleshooting guide][troubleshooting].
