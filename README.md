# QuakeWatch Kubernetes Setup Guide

## Objective
Deploy a scalable, highly available Flask web app using Kubernetes with features like autoscaling, config management, secrets, cron jobs, and health probes.

---

## Prerequisites
- Docker
- Minikube
- kubectl

---

## Step 1: Start Minikube
```bash
minikube start

##Step 2: Build Docker Image inside Minikube
# For PowerShell:
minikube docker-env | Invoke-Expression

docker build -t quakewatch:latest .


##Step 3: Apply Kubernetes Manifests
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
kubectl apply -f cronjob.yaml

##Step 4: Access the Application
minikube service quakewatch-service

##Step 5: Check Horizontal Pod Autoscaler
kubectl get hpa



File Descriptions
app.py - Flask web app source code

Dockerfile - Docker image definition

docker-compose.yml - Docker compose for local container orchestration

deployment.yaml - Kubernetes Deployment + probes

service.yaml - Kubernetes Service exposing the app

hpa.yaml - Horizontal Pod Autoscaler configuration

configmap.yaml - Configuration data as ConfigMap

secret.yaml - Sensitive data as Secret

cronjob.yaml - Kubernetes CronJob for periodic tasks

Notes

Ensure the Docker image is built inside Minikube to avoid image pull issues.

Adjust replicas, CPU targets, and schedules as needed.

Use kubectl logs and kubectl describe for debugging pods.