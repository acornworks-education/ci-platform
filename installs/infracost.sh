#!/bin/bash

helm repo add infracost https://infracost.github.io/helm-charts/
helm repo update
kubectl create ns infracost

export INFRACOST_API_KEY=ico-oPwZTBBWK7Tr622DZ2Zngh6eTlvcMwrp

helm install cloud-pricing-api infracost/cloud-pricing-api \
  --namespace infracost \
  --set infracostAPIKey="${INFRACOST_API_KEY}" \
  --set postgresql.postgresqlPassword="P@ssw0rd"

# helm --namespace infracost uninstall cloud-pricing-api

kubectl -n infracost expose deploy cloud-pricing-api --port 60001 --target-port 4000 --type LoadBalancer --name cloud-pricing-api-60001
