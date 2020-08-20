# References
- [References](#references)
	- [config.yaml](#configyaml)
		- [Config file field description](#config-file-field-description)
	- [input.json](#inputjson)
		- [Input Field Descriptions](#input-field-descriptions)
	- [Network Config](#network-config)
	- [Virtual Disk](#virtual-disk)
	- [Boot Action](#boot-action)
	- [Plugins](#plugins)
## config.yaml

This file contains configuration for standalone Metamorph. For running Metamorph executable, env variable *`METAMORPH_CONFIGPATH`*  should point to the location of this file.

	---
	database:
	    type: sqlite
	    path: "/tmp/db/metamorph.db"
	
	
	controller:
	    port : 8080
	
	logger:
	    apipath: /tmp/metamorph_api.log
	    controllerpath: /tmp/metamorph_controller.log
	    plugins:
	      redfishpluginpath: /tmp/redfish-plugin.log
	      isogenpluginpath: /tmp/isogen-plugin.log
	
	templates:
	    rootdir: /root/go/src/github.com/xyz/MetaMorph
	    preseed:
	        config:  configs/templates/preseed.tmpl
	        filepath: preseed/hwe-ubuntu-server.seed
	    grub:
	        config:  configs/templates/grub.tmpl
	        filepath: grub.conf
	    isolinux:
	        config: configs/templates/hwe_kernel/isolinux_txt.cfg
	    init:
	        config: configs/templates/init.sh
	        filepath: init.sh
	    service:
	        config: configs/templates/metamorph-client.service
	        filepath: metamorph-client.service
	    netplan:
	        config: configs/templates/netplan.tmpl
	        filepath: 50-cloud-init.yaml
	    agent_config:
	        config:  configs/templates/agent_config.tmpl
	        filepath: agent_config.yaml
	
	assets:
	   rootdir: /root/go/src/github.com/xyz/MetaMorph/assets
	   agent_binary:
	          src:  files/metamorph_agent
	          dest: metamorph_agent
	
	iso:
	  rootpath: /tmp/iso_root
	  tempdir: /tmp/iso_root/isos
	
	
	http:
	  rootpath: /tmp/http_root
	
	provisioning:
	    ip : "32.xx.xx.13"
	    port:  3190
	    httpport: 31180
	
	
	pluginlocation: "/root/go/src/github.com/xyz/MetaMorph/assets/files"
	
	testing:
	    inputfile: "/root/go/src/github.com/xyz/MetaMorph/examples/node1_input.json"
	
	agent:
	    node_id: "e415bbbe-be68-4705-aa05-16350e0c8151"
	    cntrl_endpoint: "localhost:4040"
	    logdir : "/tmp/metamorph"
	    temp_dir : "/tmp/metamorph/.tmp"
	
	plugins:
	    UpdateFirmware: "metamorph-redfish-plugin"
	    ConfigureRAID: "metamorph-redfish-plugin"
	    DeployISO: "metamorph-redfish-plugin"
	    GetGUUID: "metamorph-redfish-plugin"
	    CreateISO: "metamorph-isogen-plugin"
	    GetHWInventory: "metamorph-redfish-plugin"
	    PowerOff: "metamorph-redfish-plugin"
	    PowerOn: "metamorph-redfish-plugin"
	    GetPowerStatus: "metamorph-redfish-plugin"


### Config file field description

	database:
	    type: sqlite
	    path: "/tmp/db/metamorph.db"
	
	    path: "/tmp/db/metamorph.db"
	

`database.path` *string*  *\*required*

database.path is the location of the sqlite db file storage path.

	controller:
	    port : 8080




`controller.port` *integer*  *\*required*

controller.port is the Metamorph API Endpoint Port
	
	logger:
	    apipath: /tmp/metamorph_api.log
	    controllerpath: /tmp/metamorph_controller.log
	    plugins:
	      redfishpluginpath: /tmp/redfish-plugin.log
	      isogenpluginpath: /tmp/isogen-plugin.log

`logger.apipath` *string* *\*required*

log file path for Metamorph API Server

`logger.controllerpath` *string* *\*required*

log file path for Metamorph Controller Server

`logger.plugins.redfishpluginpath` *string* *\*required*

log file path for Metamorph Redfish Plugin 

`logger.plugins.isogenpluginpath` *string* *\*required*

log file path for Metamorph ISOGen Plugin 

	
	templates:
	    rootdir: /root/go/src/github.com/xyz/MetaMorph
	    preseed:
	        config:  configs/templates/preseed.tmpl
	        filepath: preseed/hwe-ubuntu-server.seed
	    grub:
	        config:  configs/templates/grub.tmpl
	        filepath: grub.conf
	    isolinux:
	        config: configs/templates/hwe_kernel/isolinux_txt.cfg
	    init:
	        config: configs/templates/init.sh
	        filepath: init.sh
	    service:
	        config: configs/templates/metamorph-client.service
	        filepath: metamorph-client.service
	    netplan:
	        config: configs/templates/netplan.tmpl
	        filepath: 50-cloud-init.yaml
	    agent_config:
	        config:  configs/templates/agent_config.tmpl
	        filepath: agent_config.yaml
	

`templates.rootdir` *string* *\*required*

Absolute path of the location storing all template files.

Example:

`templates.agent_config.config` specifies the location of agent config template file under the root directory.

`templates.agent_config.filepath` specifies the final location of the generated file w.r.t iso root directory.

	assets:
	   rootdir: /root/go/src/github.com/xyz/MetaMorph/assets
	   agent_binary:
	          src:  files/metamorph_agent
	          dest: metamorph_agent
	
`assets.rootdir` *string* *\*required*

Root directory for assets executables.

`assets.agent_binary` *string*  *\*required* 

Details of the binary file source and destination.

	iso:
	  rootpath: /tmp/iso_root
	  tempdir: /tmp/iso_root/isos
	
`iso.rootpath` *string* *\*required*

Root path of ISO related files.

`iso.rootpath.tempdir` *string* *\*required*

Location for storing vanilla ISO file retreived from Server.
	
	http:
	  rootpath: /tmp/http_root

`http.rootpath` *string* *\*required*

Folder location to serve the final repackaged ISO file.
	
	provisioning:
	    ip : "32.xx.xx.13"
	    port:  3190
	    httpport: 31180

`provisioning.ip` *string* *\*required*
`provisioning.port` *int* *\*required*
`provisioning.httpport` *int* *\*required*

Provisioning server information.	
	
	pluginlocation: "/root/go/src/github.com/xyz/MetaMorph/assets/files"

`pluginlocation` *string*  *\*required*

Location for placing plugin executables.
	
	testing:
	    inputfile: "/root/go/src/github.com/xyz/MetaMorph/examples/node1_input.json"

`testing.inputfile` *string*  *\*required* 

Input file in form of JSON for testing purpose
	
	agent:
	    node_id: "e415bbbe-be68-4705-aa05-16350e0c8151"
	    cntrl_endpoint: "localhost:4040"
	    logdir : "/tmp/metamorph"
	    temp_dir : "/tmp/metamorph/.tmp"

`agent.node_is` contains information about Metamorph agent details.
	
	plugins:
	    UpdateFirmware: "metamorph-redfish-plugin"
	    ConfigureRAID: "metamorph-redfish-plugin"
	    DeployISO: "metamorph-redfish-plugin"
	    GetGUUID: "metamorph-redfish-plugin"
	    CreateISO: "metamorph-isogen-plugin"
	    GetHWInventory: "metamorph-redfish-plugin"
	    PowerOff: "metamorph-redfish-plugin"
	    PowerOn: "metamorph-redfish-plugin"
	    GetPowerStatus: "metamorph-redfish-plugin"
`plugins` contains the mapping of API vis a vis the plugin executable

Example

`plugins.UpdateFirmware` is set to `metamorph-redfish-plugin` which is the executable implementing the said API.

## input.json

	{
	    "AllowFirwareUpgrade": true,
	    "BootActions": [
	        {
	            "control": "bash",
	            "location": "https://raw.githubusercontent.com/ruanyf/simple-bash-scripts/master/scripts/hello-world.sh",
	            "name": "Hello World",
	            "priority": 1
	        },
	        {
	            "control": "bash",
	            "location": "https://raw.githubusercontent.com/qjcg/shell-examples/master/00-fundamentals/if",
	            "name": "Fibonacci",
	            "priority": 5
	        },
	        {
	            "control": "bash",
	            "location": "https://raw.githubusercontent.com/ruanyf/simple-bash-scripts/master/scripts/list-dir.sh",
	            "name": "List Dir",
	            "priority": 1
	        },
	        {
	            "args": "apply -f",
	            "control": "kubectl",
	            "location": "https://raw.githubusercontent.com/kubernetes/website/master/content/en/examples/application/deployment.yaml",
	            "name": "Deploy Nginx",
	            "priority": 5
	        }
	    ],
	    "Domain": "xyz.cci.xyz.com",
	    "Firmwares": [
	        {
	            "name": "bios",
	            "url": "http://a.b.c.d:31180/BIOS_R6HXJ_WN64_2.6.4.EXE",
	            "version": "2.3.4"
	        },
	        {
	            "name": "raid",
	            "url": "http://a.b.c.d:31180/BIOS_R6HXJ_WN64_2.6.4.EXE",
	            "version": "2.3.4"
	        }
	    ],
	    "IPMIIP": "12.168.22.13",
	    "IPMIPassword": "1234",
	    "IPMIUser": "admin",
	    "ISOChecksum": "http://a.b.c.d:31180/ubuntu-18.04.4-server-amd64.iso.md5sum",
	    "ISOURL": "http://a.b.c.d:31180/ubuntu-18.04.4-server-amd64.iso",
	    "Model": "Gen9",
	    "NetworkConfig": "bmV0d29yOiAyCiAgcmVuZGVyZXI6IG5ldHdvcmtkIAogIGV0aGVybmV0czoKICAgIGVubzQ6CiAgICAgIGRoY3A0OiB0cnVlCiAgICAgIG1hdGNoOgogICAgICAgIG5hbWU6ICJlbjA0IgogICAgZW5wMTM1czBmMDoKICAgICAgbXR1OiA5MjE0CiAgICAgIG1hdGNoOgogICAgICAgIG5hbWU6IGVucDEzNXMwZjAiCiAgICBlbnA5NHMwZjE6CiAgICAgIG10dTogOTIxNAogICAgICBtYXRjaDoKICAgICAgICBuYW1lOiBlbnA5NHMwZjEKICBib25kczoKICAgIGJvbmQwOgogICAgICBtdHU6IDkyMTQKICAgICAgaW50ZXJmYWNlczogCiAgICAgIC0gZW5wMTM1czBmMAogICAgICAtIGVucDk0czBmMQogICAgICBwYXJhbWV0ZXJzOiAKICAgICAgICBkb3duLWRlbGF5OiAzMDAwCiAgICAgICAgbGFjcC1yYXRlOiBmYXN0CiAgICAgICAgbWlpLW1vbml0b3ItaW50ZXJ2YWw6IDEwMAogICAgICAgIG1vZGU6IDgwMi4zYWQKICAgICAgICB1cC1kZWxheTogMTAwMAogIHZsYW5zOgogICAgb2FtOgogICAgICBpZDogNDEKICAgICAgbGluazogYm9uZDAKICAgICAgZGhjcDQ6IG5vCiAgICAgIG10dTogOTIxNAogICAgICBhZGRyZXNzZXM6IFszMi42OC4yMjAuMTQvMjYsIF0KICAgICAgZ2F0ZXdheTQ6IDMyLjY4LjIyMC4xCiAgICAgIG5hbWVzZXJ2ZXJzOgogICAgICAgIGFkZHJlc3NlczogWzE1MC4yMzQuMjEwLjUsIDE1MC4yMzQuMjEwLjIwNSwgMTM1LjE4OC4zNC4xMjQsIF0K",
	    "OsDisk": "/dev/sda",
	    "Partitions": [
	        {
	            "filesystem": {
	                "fstype": "ext4",
	                "mount-options": "defaults",
	                "mountpoint": "/"
	            },
	            "partitionName": "root",
	            "size": "30g"
	        },
	        {
	            "bootable": true,
	            "filesystem": {
	                "fstype": "ext4",
	                "mount-options": "defaults",
	                "mountpoint": "/boot"
	            },
	            "name": "boot",
	            "primary": true,
	            "size": "1g"
	        },
	        {
	            "filesystem": {
	                "fstype": "ext4",
	                "mount-options": "defaults",
	                "mountpoint": "/var/log"
	            },
	            "name": "var-log",
	            "size": "100g"
	        },
	        {
	            "filesystem": {
	                "fstype": "ext4",
	                "mount-options": "defaults",
	                "mountpoint": "/var"
	            },
	            "name": "var",
	            "size": ">300g"
	        }
	    ],
	    "Plugins": {
	        "APIs": [
	            {
	                "Name": "DeployISO",
	                "Plugin": "metamorph-redfish-plugin"
	            },
	            {
	                "Name": "CreateISO",
	                "Plugin": "metamorph-isogen-plugin"
	            }
	        ]
	    },
	    "RAID_reset": false,
	    "SSHPubKeys": [
	        {
	            "SSHPubKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCurXRaUe/ukR84FRseqnrNdDLg6zS4qtJi8e8o4VCNxbV0Jsu5iw17ZBF1B1uF8+Bdhz9eiYIkokxaiVkHHqOpRzF5v4phRK+k4MugjT3OAR78cEdg8MR2om5IIMbYYhVyjY1IyZOZv9PQ1noqzyR2Glo6q7AHPadVY2emk16VmmcVJc/z+6awZXitwdamFDRZ9HK+xoRCd6WDIIphJbI6nnFw2ytokgfpqptkwNGQ/2q8/skvRBaB78byIMU70O1q0fQEbm9VhbjmIE/qwNYEsVMAdHE6EYYyW1YnC3VqhBGlBqF/KPxTX/uQksOmvXoydbnvtaTRG0qq/AAvdJw5 root@r07c001"
	        },
	        {
	            "SSHPubKey": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDtIbTb2c33GhoprVOdZB5EvuCs7JOo5dgq8z3aOpJO/7efCF3Wft/Q0ve8ndRNVNt30KxpK7ro5ad31yloVQqj/MhYvI/fPMsyocCyPo+fJOf/8+u2TEMJUaDjwTRCnsPSu8fendpNt9HdreZcUT5R/foN3dpPfUiAPREgpvMqVfE7rtSyGs8ZRRTVYIohBwOVemCrdIGjjIzbGVLQfRWHkuJpl6Js2kHlO6trsE7aEiEqkaGEaJGCyGOlSS119lBsvsiEc4ExNczKAduMYY86xSxGo7zpf2R6mQTOmCHVSSwSfy0UHIgDVFPIVgyZSI27F2NLYnJeAmRqN9PNitPp a96e@xyz.com"
	        }
	    ],
	    "grubConfig": "image=bionic isolcpus=0-3,44-47 amd_iommu=on kernel_package=linux-image-5.0.0-23-generic kernel=hwe-18.04 hugepagesz=1G hugepages=160 intel_iommu=on console=ttyS1,115200n8 transparent_hugepage=never",
	    "kvmPolicy": {
	        "cpuAllocation": "1:1",
	        "cpuHyperthreading": "enabled",
	        "cpuPinning": "enabled"
	    },
	    "name": "mtn52r07c001",
	    "vendor": "Dell",
	    "virtualDisks": [
	        {
	            "DiskName": "osdisk",
	            "PhysicalDisks": [
	                {
	                    "PhysicalDisk": "Disk.Bay.0:Enclosure.Internal.0-1:RAID.Slot.6-1",
	                    "VirtualDiskID": 1
	                },
	                {
	                    "PhysicalDisk": "Disk.Bay.1:Enclosure.Internal.0-1:RAID.Slot.6-1",
	                    "VirtualDiskID": 1
	                }
	            ],
	            "RaidController": "RAID.Slot.6-1",
	            "raidType": 1
	        },
	        {
	            "PhysicalDisks": [
	                {
	                    "PhysicalDisk": "Disk.Bay.4:Enclosure.Internal.0-1:RAID.Slot.6-1",
	                    "VirtualDiskID": 2
	                },
	                {
	                    "PhysicalDisk": "Disk.Bay.5:Enclosure.Internal.0-1:RAID.Slot.6-1",
	                    "VirtualDiskID": 2
	                }
	            ],
	            "RaidController": "RAID.Slot.6-1",
	            "name": "ephemeral",
	            "raidType": 1
	        }
	    ]
	


### Input Field Descriptions

`RAID_reset`

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

## Network Config

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


## Plugins
This section list the APIs that needs to be overridden.


  	 Plugins: 
          APIs: 
             - Name: "DeployISO"
               Plugin: "metamorph-redfish-plugin" 
			 - Name: "CreateISO"
               Plugin: "metamorph-isogen-plugin" 

*`Name`* *string* 

The name of the API which needs to be overridden. The Metamorph configuration files define a set of out of  box APIs via a vis plugin modules.

*`Plugin`* *string*

The name of the associated plugin. This could a new plugin which supports the associated API.
