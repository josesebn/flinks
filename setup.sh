#!/usr/bin/env bash
microk8s kubectl enable helm3 registry dns
docker build -t flinks .
docker run -d --name flinks flinks

curl http://localhost:8000
microk8s kubectl create -n flinks
microk8s kubectl apply -f flinksdeployment.yaml -n flinks
kubectl expose deployment flinks-deployment --type=LoadBalancer --name=flinks-service

microk8s kubectl apply -f ingress-controller.yaml -n flinks