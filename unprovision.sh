gcloud deployment-manager deployments list | awk '{ print $1}' | tail -n +2 | xargs

echo "gcloud deployment-manager deployments delete"
