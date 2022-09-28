#!/usr/bin/bash

RESET="\033[0m"
RED="\e[31m"
GREEN="\033[32m"

cluster=`kubectl config current-context`
echo -e "===== current cluster ====="
echo -e "$GREEN $cluster $RESET"

echo -e "===== create monitor namespace ====="
kubectl create ns kube-ops

echo -e "===== install pormetheus ====="
kubectl apply -f ./prometheus --validate=false

echo -e "===== install grafana ====="
kubectl apply -f ./grafana

echo -e "===== install kube-state-metrics ====="
kubectl apply -f ./kube-state-metrics

echo -e "===== expose prometheus service"
minikube service -n kube-ops prometheus --url
echo -e "===== expose grafana service ====="
minikube service -n kube-ops grafana-service --url

echo -e "===== monitor install success ====="
# kubectl port-forward -n kube-ops services/prometheus 9090
# kubectl port-forward -n kube-ops services/grafana-service 3000