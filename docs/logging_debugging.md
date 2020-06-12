# Logs and Debugging


## Metamorph


		kubectl -n metamorph get pod
		NAME                        READY   STATUS    RESTARTS   AGE
		metamorph-dc68bf875-zw82l   3/3     Running   0          2d

Metamorh pod is running in `metamorph` namespace. There are mainly 3 containers inside the metamorph pod

* *<strong>metamorph-controller</strong>* 	- MetaMorph Controller does the all heavy lifting like Prepare the customized ISO on the fly, Deploy Baremetal node via Redfish, Executing Boot Actions etc  

* *<strong>metamorph-api</strong>* - MetaMorph API interface for other components/services in the cluster to talk to MetamMorph

* *<strong>metamorph-nginx</strong>* - Nginx webserver to serve the OS ISO and other actifacts, the target server needs


To see the logs of MetaMorph Components 


 		kubectl -n metamorph logs -f metamorph-dc68bf875-zw82l -c metamorph-controller


## Metal3 Baremetal Operator

MetaMorph use Metal3 Baremetal Operator with a custom MetaMorph provisioner. The Custom Provisioner helps to avoid the complex requirements like the need to have DHCP, TFTP servers and other constraints with Ironic. Metamorph completly rely on the Redfish APIs to do all operations.



	kubectl -n metal3 get pod
	NAME                                  READY   STATUS    RESTARTS   AGE
	baremetal-operator-85b5bf9684-smr27   1/1     Running   790        5d22h

	kubectl -n metal3 logs  -f baremetal-operator-85b5bf9684-smr27


