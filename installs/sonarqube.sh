#!/bin/bash

# https://github.com/SonarSource/helm-chart-sonarqube/tree/master/charts/sonarqube

helm repo add sonarqube https://SonarSource.github.io/helm-chart-sonarqube
helm repo update
kubectl create namespace sonarqube
helm upgrade --install -n sonarqube sonarqube sonarqube/sonarqube

kubectl -n sonarqube expose pod sonarqube-sonarqube-0 --port 60002 --target-port 9000 --type LoadBalancer --name sonarqube-sonarqube-60002


curl sqa_60533015b137156157d7634a99aa26d1074510e8

curl -u sqa_60533015b137156157d7634a99aa26d1074510e8: -X POST -H "Content-Type: application/x-www-form-urlencoded" http://localhost:60002/api/projects/create -d "name=feature-test&project=feature-test"