```sh
gcloud compute project-info add-metadata --metadata-from-file sshKeys=~/.ssh/id_rsa.pub  ##Warning!!
gcloud compute instances add-metadata [INSTANCE_NAME] --metadata-from-file ssh-keys=[KEY_FILE_NAME].pub`
gcloud dns record-sets export record --zone=xfc
```

