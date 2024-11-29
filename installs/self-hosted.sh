#!/bin/bash

kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.8.2/cert-manager.yaml

helm repo add actions-runner-controller https://actions-runner-controller.github.io/actions-runner-controller

helm upgrade --install --namespace runners --create-namespace\
  --set=authSecret.create=true\
  --set=authSecret.github_token="ghp_12132132131231"\
  --set "githubWebhookServer.enabled=true"\
  --wait actions-runner-controller actions-runner-controller/actions-runner-controller

kubectl -n runners expose deploy/actions-runner-controller-github-webhook-server --port 63080 --target-port 8000 --protocol TCP --type LoadBalancer --name webhook

kubectl apply -f runner-label.yaml

