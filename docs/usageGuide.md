# MetaMorph Usage Guide


## Deploy Standalone Node using MetaMorph

First step is to create a site/node manifest(s) . An example directory of a site will look like this.


		.
		|-- sites
		|   -- jackson
		|       |-- node1
		|		|	|-- bmh.yaml
		|       |   |-- kustomization.yaml
		|       |   |-- network_config.yaml
		|       |   |-- userData.yaml
		|       |    -- userDataConfig
		|       -- node2
		|           |-- bmh.yaml
		|           |-- kustomization.yaml
		|			|-- network_config.yaml
		|           |-- userData.yaml
		|            -- userDataConfig
		-- types
		    -- vvig
		        -- userDataSecret.yaml



see the [References](/references) section for more details

Once we the site/node manifests ready. then we can deploy it

<pre><code>
cd sites/vvig/node1
kustomize build --enable_alpha_plugins . | kubectl apply -f -
</code></pre>

To see the nodes deployed

<pre><code>
kubectl -n metal3 get bmh 
NAME          STATUS   PROVISIONING STATUS   CONSUMER   BMC                                  HARDWARE PROFILE   ONLINE   ERROR
node1         OK       provisioning                     redfish://32.xx.xx.121/redfish/v1    unknown            true
</code></pre>



To delete the node

<pre><code>
kubectl -n metal3 delete bmh node1
</code></pre>

*Note: Delete action will not wipe the OS/VirtualDisk on the target node.*