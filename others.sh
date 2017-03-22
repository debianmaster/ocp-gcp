/usr/local/bin/start_openshift.sh:

#!/bin/bash
cd /opt/openshift/
openshift start --public-master='https://<PUBLIC_IP>:8443' --master='https://<PRIVATE_IP>:8443'
/etc/systemd/system/openshift.service:

[Unit]
Description=OpenShift Origin Server

[Service]
Type=simple
ExecStart=/usr/local/bin/start_openshift.sh
