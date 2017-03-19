#!/bin/bash
sudo yum -y erase ansible
sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel
sudo pip install -Iv ansible==2.2.0.0
sudo yum install -y git
git clone https://github.com/openshift/openshift-ansible.git
cd openshift-ansible
git checkout release-1.5 
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
mkdir -p $HOME/ansible/
export UNAME=`whoami`
cat > $HOME/ansible/hosts << EOF

[OSEv3:children]
masters
nodes
lb

# Set variables common for all OSEv3 hosts
[OSEv3:vars]
# SSH user, this user should allow ssh based auth without requiring a password
ansible_ssh_user="$UNAME"
ansible_become=yes
openshift_release=v1.5.0
containerized=true
#openshift_install_examples=true
#openshift_cloudprovider_kind=gce
#openshift_cloudprovider_aws_access_key=aws_access_key_id
#openshift_cloudprovider_aws_secret_key=aws_secret_access_key
openshift_master_cluster_method=native
openshift_master_cluster_public_hostname=cloud.expertsfactory.com
openshift_master_cluster_hostname=cloud.expertsfactory.com
openshift_master_default_subdomain=apps.cloud.expertsfactory.com
openshift_hosted_metrics_deploy=true
os_sdn_network_plugin_name=redhat/openshift-ovs-multitenant
openshift_hosted_metrics_public_url=https://hawkular-metrics.apps.cloud.expertsfactory.com/hawkular/metrics
openshift_docker_options="--selinux-enabled --insecure-registry 172.30.0.0/16"
openshift_image_tag=latest
openshift_master_console_port=8443
openshift_master_api_port=8443
openshift_hosted_registry_selector='region=infra'
openshift_hosted_metrics_storage_kind=EmptyDir
deployment_type=origin

# uncomment the following to enable htpasswd authentication; defaults to DenyAllPasswordIdentityProvider
openshift_master_identity_providers=[{'name': 'htpasswd_auth', 'login': 'true', 'challenge': 'true', 'kind': 'HTPasswdPasswordIdentityProvider', 'filename': '/etc/origin/master/htpasswd'}]
openshift_master_htpasswd_users={'demo': '$apr1$.MaA77kd$Rlnn6RXq9kCjnEfh5I3w/.'}


#https://github.com/openshift/openshift-ansible/blob/master/inventory/byo/hosts.ose.example

# host group for masters
[masters]
openshift-master-1-vm 


# host group for etcd
[etcd]
openshift-infra-1-vm   etcd_hostname=openshift-infra-1-vm 


# host group for nodes, includes region info
[nodes]
openshift-master-1-vm  openshift_node_labels="{'type':'master'}"
openshift-node-1-vm    openshift_node_labels="{'type':'node'}"
openshift-node-2-vm    openshift_node_labels="{'type':'node'}"
openshift-infra-1-vm  openshift_node_labels="{'sType':'lb'}"

[lb]
openshift-infra-1-vm  openshift_node_labels="{'sType':'lb'}"

EOF


echo "Bootstrap complete"
