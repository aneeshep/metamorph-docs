## QuickStart


1. Login to the Metamorph ControlPlane node

<code> ssh ubuntu@32.131.6.12 </code>

2. Prepare the node manifests

<pre><code>
	sudo -i
	cd /opt/metamorph/manifests/sites

	#Create a directory for new site
	mkdir livonia 

	#Copy existing site manifest to the new site location
	cp -r jackson/jacmsrsv121 livonia/ 


	cd livonia

	#update the node related reference in the manifest to match the new node
	mv jacmsrsv121 livmirsv134

	#Update the IPMI IP and the name of bmc credential secret and UserData, 
	vi livmirsv134/bmh.yaml

	apiVersion: metal3.io/v1alpha1
	kind: BareMetalHost
	metadata:
	  labels:
	    metalkubedemo:
	  name: bmh
	  namespace: metal3
	spec:
	  bmc:
	    address: redfish://<mark>32.xxx.xxx.14</mark>/redfish/v1
	    credentialsName: <mark>livmirsv134</mark>-secret
	  image:
	    checksum: http://32.131.6.12:31180/ubuntu-18.04.4-server-amd64.iso.md5sum
	    url: http://32.131.6.12:31180/ubuntu-18.04.4-server-amd64.iso
	  online: true
	  userData:
	    name: <mark>livmirsv134</mark>-user-data
	    namespace: metal3

	# Update namePrefix, IPMI Credentials
	vi livmirsv134/kustomization.yaml

	kind: Kustomization
	namespace: metal3

	namePrefix: <mark>livmirsv134</mark>-
	generatorOptions:
	  disableNameSuffixHash: true

	resources:
	- bmh.yaml

	secretGenerator:
	- name: secret
	  literals:
	  - username=<mark>username</mark>
	  - password=<mark>password</mark>

	generators:
	- userData.yaml


	# Update network config for the node.
	# Metamorph use [netplan](https://netplan.io/) to configure network. 
	# Modify the network config with a valid netplan config
	vi livmirsv134/network_config.yaml
</code></pre>

3. Deploy the node

<pre><code>  
kustomize build --enable_alpha_plugins livmirsv134 | kubectl apply -f - 

secret/livmirsv134-secret created
secret/livmirsv134-user-data unchanged
baremetalhost.metal3.io/livmirsv134-bmh created

</code></pre>


4. Check the status of the node 

<pre><code> 
kubectl get bmh -n metal3
NAME              STATUS   PROVISIONING STATUS   CONSUMER   BMC                                  HARDWARE PROFILE   ONLINE   ERROR
jacmsrsv123-bmh   OK       provisioned                      redfish://32.xx.xxx.166/redfish/v1   unknown            true
livmirsv134-bmh   OK       provisioning                     redfish://32.xx.xxx.14/redfish/v1    unknown            true
</code></pre>


5. At this point we can check the idrac/ilo virtual console to check the progress of the deployment
Once the OS is installed. MetaMorph will start execute the [BootActions](/references/#boot-action) defined for this node. The node will be marked 'provisioned' after all boot actions completed


Check [References](/references) and [Logging and Debugging](/logging_debugging) for more details



