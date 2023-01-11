#!/bin/bash

helm repo add evryfs-oss https://evryfs.github.io/helm-charts/
helm install dependency-track evryfs-oss/dependency-track --namespace dependency-track --create-namespace

kubectl -n dependency-track expose deploy/dependency-track-apiserver --port 60003 --target-port 8080 --type LoadBalancer --name dependency-track-apiserver-60003
kubectl -n dependency-track expose deploy/dependency-track-frontend --port 60013 --target-port 8080 --type LoadBalancer --name dependency-track-frontend-60013

kubectl -n dependency-track edit deploy/dependency-track-frontend
kubectl -n dependency-track rollout restart deploy/dependency-track-frontend

kubectl get pods -n dependency-track