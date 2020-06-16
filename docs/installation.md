# MetaMorph Installation
<mark>*This Page need to be updated. Work in Progress*</mark>


Prerequisites:

Create an apparmor profile.
<pre><code>
$ cd /etc/apparmor.d
$ apparmor_parser calico-node-v1
</code></pre>

Create a seccomp profile
<pre><code>
$ cd /var/lib/kubelet/seccomp/
create a `seccomp_default` file with content of https://raw.githubusercontent.com/moby/moby/master/profiles/seccomp/default.json
</code></pre>


Clone the required git repos as follows:

<pre><code>
https://gerrit.mtn5.cci.att.com/admin/repos/aic-clcp-site-manifests
https://gerrit.mtn5.cci.att.com/admin/repos/aic-clcp-security-manifests
</code></pre>


Use global manifests present in the root directory.
`/root/aic-clcp-manifests`

Clone the Promenade git repository
`https://gerrit.mtn5.cci.att.com/#/admin/projects/mirrors/airship/promenade`


<pre><code>
NEW_SITE=mySite # replace with the name of your site (e.g., nyc)
cd ~/aic-clcp-site-manifests/site
cp -r mtn57a "$NEW_SITE"

#Build your site files is as follows:
site/$NEW_SITE/networks/physical/networks.yaml
site/$NEW_SITE/baremetal/nodes.yaml
site/$NEW_SITE/networks/common-addresses.yaml
site/$NEW_SITE/pki/pki-catalog.yaml
All other site files
</code></pre>
disable/enable chart_groups in aic-clcp-manifests/type/cruiser/software/manifests/full-site.yaml to bootstrap the node with required chart_gropus.

Run the below steps after making all changes to the site manifests.

<pre><code>
export PROMENADE_TMP=promenade_tmp
export PROMENADE_TMP_LOCAL=promenade_tmp_local
</code></pre>


Use pegleg to perform the merge that will yield the combined global + site type + site YAML. From your home directory:

`./aic-clcp-manifests/tools/pegleg.sh site -r aic-clcp-site-manifests -e global=aic-clcp-manifests -e secrets=aic-clcp-security-manifests collect nyc -s nyc_collected`


Certificate.yaml and Genesis.sh Generation

<pre><code>
$ chmod 777 -R nyc_collected
$ ./promenade/tools/simple-deployment.sh nyc_collected/ nyc_bundle
</code></pre>

After the nyc_bundle has been successfully created, simple-deployment.sh will generate a decryption key for use during genesis.sh script execution.

Example Key from the output of above command:
<pre><code>
Copy this decryption key for use during script execution:
Ba93fd04aa3e2f553858bd5e9f795c1bba7e6ac814e73602624c2abce3b423af2a154a1af93298456cf83e15c49681e4

$ export PROMENADE_ENCRYPTION_KEY=Ba93fd04aa3e2f553858bd5e9f795c1bba7e6ac814e73602624c2abce3b423af2a154a1af93298456cf83e15c49681e4
</code></pre>


Run genesis.sh
<pre><code>
$ cd nyc_bundle
$ nohup ./genesis.sh &
</code></pre>

Check `nohup.out` in the current directory for logs.

