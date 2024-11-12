#!/bin/bash

kubectl run front-end-app --image=nginx --labels role=front-end --port=80
kubectl run back-end-api-app --image=nginx --labels role=back-end-api --port=80
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --port=80
kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --port=80

kubectl apply -f front-end-service.yaml
kubectl apply -f back-end-api-service.yaml
kubectl apply -f admin-front-end-service.yaml
kubectl apply -f admin-back-end-api-service.yaml
