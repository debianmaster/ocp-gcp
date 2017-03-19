gcloud deployment-manager deployments create openshift-master --config=masters.yml &
gcloud deployment-manager deployments create openshift-nodes --config=nodes.yml &
gcloud deployment-manager deployments create openshift-basiton --config=basiton.yml &
gcloud deployment-manager deployments create openshift-infra --config=infra.yml &
