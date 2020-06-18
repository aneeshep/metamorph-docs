#References

## userDataSecret.yaml

`location` : `type/vvig/userDataSecret.yaml`

Most the configs like the Network,Storage are passed via the `userDataSecret`.  
The common configs for all the nodes are kept at `types/<site_type>/userDataSecret.yaml`



	RAID_reset: false
	OsDisk: /dev/sda
	vendor: Dell
	Model: Gen9
	biosVersion: 2.0.0
	CPLDFirmwareVersion: 3.43.4
	RAIDFirmwareVersion: 4.5.6
	FirmwareVersion: 32.32.32
	grubConfig: "image=bionic isolcpus=0-3,44-47 amd_iommu=on kernel_package=linux-image-5.0.0-23-generic kernel=hwe-18.04 hugepagesz=1G hugepages=160 intel_iommu=on console=ttyS1,115200n8 transparent_hugepage=never"
	Partitions:
	  - partitionName: root
	    size: 30g
	    filesystem:
	      mountpoint: /
	      fstype: ext4
	      mount-options: defaults
	  - name: boot
	    size: 1g
	    bootable: true
	    primary: true
	    filesystem:
	      mountpoint: /boot
	      fstype: ext4
	      mount-options: defaults
	  - name: var-log
	    size: 100g
	    filesystem:
	      mountpoint: /var/log
	      fstype: ext4
	      mount-options: defaults
	  - name: var
	    size: '>300g'
	    filesystem:
	      mountpoint: /var
	      fstype: ext4
	      mount-options: defaults
	virtualDisks:
	  - DiskName: osdisk
	    raidType: 1
	    RaidController: RAID.Slot.6-1
	    PhysicalDisks:
	      - VirtualDiskID: 1
	        PhysicalDisk: 'Disk.Bay.0:Enclosure.Internal.0-1:RAID.Slot.6-1'
	      - VirtualDiskID: 1
	        PhysicalDisk: 'Disk.Bay.1:Enclosure.Internal.0-1:RAID.Slot.6-1'
	  - DiskName: ephemeral
	    raidType: 1
	    RaidController: RAID.Slot.6-1
	    PhysicalDisks:
	      - VirtualDiskID: 2
	        PhysicalDisk: 'Disk.Bay.4:Enclosure.Internal.0-1:RAID.Slot.6-1'
	      - VirtualDiskID: 2
	        PhysicalDisk: 'Disk.Bay.5:Enclosure.Internal.0-1:RAID.Slot.6-1'
	BootActions:
	- location: http://32.xxx.xx.12:31180/deploy_airskiff.sh
	  control: bash
	  name: Deploy Airskiff
	  priority: 1
	- location: http://32.xxx.xx.12:31180/deploy_sec_tools.sh
	  control: bash
	  name: Deploy Sec tools
	  priority: 10






#### Manifest Field Descriptions


* `RAID_reset` *bool*  *\*required*

If sets to true, MetaMorph will erase all existing RAID configurations and re-create the RAID based on the `virtualDisks` config.  
*Note*: Setting this to true will erase all the data on all disks on the node

* `OsDisk` *string*  *\*required*

The disk into which the OS will be installed

* `vendor` *string* *\*optional*

Vendor name. Example: Dell, HP etc

* `Model` *string* *\*optional*

Model of the Server. Example Gen9, Gen8 etc

*`biosVersion`* *string* *\*optional*  *\*Alpha Feature*

Required Bios Version. example "2.0.0".  
*Note: This is an alpha feature. May not work in some cases*

*`CPLDFirmwareVersion`* *string* *\*optional*  *\*Alpha Feature*

Required CPLD firmware Version. example "3.43.4"  
*Note: This is an alpha feature. May not work in some cases*

*`RAIDFirmwareVersion`* *string* *\*optional*  *\*Alpha Feature*

Required RAID firmware version. example "4.5.6"  
*Note: This is an alpha feature. May not work in some cases* 

*`FirmwareVersion`* *string* *\*optional*  *\*Alpha Feature* 

Required Firmware (iDRAC/ILO) version. example "32.32.32"  
*Note: This is an alpha feature. May not work in some cases* 

*`grubConfig`*  *string* *\*required*  
Parameters needed to add to the Grub Config  
 Most of the case you don't need to change this config  
 <pre>example<code>"grubConfig": "image=bionic isolcpus=0-3,44-47 amd_iommu=on kernel_package=linux-image-5.0.0-23-generic kernel=hwe-18.04 hugepagesz=1G hugepages=160 intel_iommu=on console=ttyS1,115200n8 transparent_hugepage=never</code></pre>
 *Note: Incorrect values in this config may cause issues while booting the server*

*`Partitions`* *List of <`Partiions`\>* *\*required*  
See the above example for more details.


*`virtualDisks`* *List of <`virtualDisk`\>* *\*optional*  
See the above example for more details.

*Note: This is supported for Dell servers only*


*`BootActions`* *List of <`BootAction`\>* *\*optional*  
BootActions are the scripts that will be executed on the first boot after the OS installation.
Same Priority tasks will be executed in parelell. See the above example for more details.





## network_config.yaml
`location` : `sites/vvig/node1/network_config.yaml`


		network:
		  version: 2
		  renderer: networkd
		  ethernets:
		    eno4:
		      dhcp4: true
		      match:
		        name: "en04"
		    enp135s0f0:
		      mtu: 9214
		      match:
		        name: enp135s0f0"
		    enp94s0f1:
		      mtu: 9214
		      match:
		        name: enp94s0f1
		  bonds:
		    bond0:
		      mtu: 9214
		      interfaces:
		      - enp135s0f0
		      - enp94s0f1
		      parameters:
		        down-delay: 3000
		        lacp-rate: fast
		        mii-monitor-interval: 100
		        mode: 802.3ad
		        up-delay: 1000
		  vlans:
		    oam:
		      id: 41
		      link: bond0
		      dhcp4: no
		      mtu: 9214
		      addresses: [32.xx.xx.14/26, ]
		      gateway4: 32.xx.xx.1
		      nameservers:
		        addresses: [150.xx.xx.5, 150.xx.xx.205, 135.xx.xx.124, ]


Network config file is a plain netplan file that is responsible for configuring the network in the target node.   
See [https://netplan.io](https://netplan.io) for more details


## kustomization.yaml
`location` : `sites/vvig/node1/kustomization.yaml`


		kind: Kustomization
		namespace: metal3


		generatorOptions:
		  disableNameSuffixHash: true

		resources:
		- bmh.yaml

		secretGenerator:
		- name: node1-secret
		  literals:
		  - username=<username>
		  - password=<password>

		generators:
		- userDataConfig.yaml




kustomization.yaml is the main file that puts all other files togehter. When executed with `kustomize build --enable_alpha_plugins .` kustomize will parse the `kustomization.yaml` and build the kubernetes manifests required to deploy the target node.

## bmh.yaml
`location` : `sites/vvig/node1/bmh.yaml`



		apiVersion: metal3.io/v1alpha1
		kind: BareMetalHost
		metadata:
		  labels:
		    metalkubedemo:
		  name: node1
		  namespace: metal3
		spec:
		  bmc:
		    address: redfish://<xx.xx.xx.xx>/redfish/v1
		    credentialsName: node1-secret
		  image:
		    checksum: http://<xx.xx.xx.xx:port>/ubuntu-18.04.4-server-amd64.iso.md5sum
		    url: http://<xx.xx.xx.xx:port>/ubuntu-18.04.4-server-amd64.iso
		  online: true
		  userData:
		    name: node1-user-data
		    namespace: metal3


This file holds the config of the baremetal nodes , like the IPMI ip, username , password and the iso images etc


## userDataConfig.yaml
`location` : `sites/vvig/node1/userDataConfig.yaml`


		apiVersion: metamorph.io/v1
		kind: UserData
		metadata:
		  name: node1-user-data
		namespace: metal3
		network_config:  network_config.yaml
		resources:
		- ../../../types/vvig/userDataSecret.yaml
		- userData.yaml



Most of the case, you don't have to change this file. This file tells metamorph to take all the files in `userData.yaml` file and merge it together while creating the kuberentes manifests


## userData.yaml
`location` : `sites/vvig/node1/userData.yaml`

		---
		RAID_reset: false
		vendor: Dell



Most of the case, you don't have to change this file. this file tell the metamorph to override the values in the `types/<site_type>/userDataSecret.yaml`




## Virtual Disk 


	virtualDisks:
	  - DiskName: osdisk
	    raidType: 1
	    RaidController: RAID.Slot.6-1
	    PhysicalDisks:
	      - VirtualDiskID: 1
	        PhysicalDisk: 'Disk.Bay.0:Enclosure.Internal.0-1:RAID.Slot.6-1'
	      - VirtualDiskID: 1
	        PhysicalDisk: 'Disk.Bay.1:Enclosure.Internal.0-1:RAID.Slot.6-1'


VirtualDisk define how to create RAIDs on the server. 



*`DiskName`* *string* *\*required* 

Name of the Virtual Disk: example `osdisk`

*`raidType`* *number* *\*required* 

raidType the is RAID level need to setup. example 0,1,2 etc

*`RaidController`* *string* *\*required* 

  The name of the Raid Controller.

*`VirtualDiskID`* *string* *\*required* 

 Virtual Disk number. This number has to be same for all the physical disks inside the given virtualDisk

*`PhysicalDisk`* *string* *\*required* 

Physical Disk unique ID



## Boot Action

	BootActions:
	- location: http://32.131.6.12:31180/deploy_airskiff.sh
	  control: bash
	  name: Deploy Airskiff
	  priority: 1



BootActions are the scripts that will be executed on the first boot after the OS installation. Same Priority tasks will be executed in parelell. Pririties can be any number ranging from 1 - 1000 . Lowest number will have higher priroty.   
Logs of each boot action will be created at /opt/metamorph/logs/<boot_action_name\>.log . example: `/opt/metamorph/logs/deploy_airskiff.sh.log`


*`location`* *string* *\*required* 

Location of the script. Can be any http/https url 

*`control`* *string* *\*required* 

The command used to execute the script. it can be any command available in the target host. example: bash, kubectl etc

*`name`* *string* *\*required* 

Name of the BootAction. 

*`priority`* *number* *\*required* 

Priority of the task. Pririties can be any number ranging from 1 - 1000 Lowest number will have higher priroty. Same Priority tasks will be executed in parelell. 




