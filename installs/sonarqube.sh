#!/bin/bash

# https://github.com/SonarSource/helm-chart-sonarqube/tree/master/charts/sonarqube

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube

kubectl -n sonarqube expose deploy cloud-pricing-api --port 60002 --target-port 9000 --type LoadBalancer --name cloud-pricing-api-60001