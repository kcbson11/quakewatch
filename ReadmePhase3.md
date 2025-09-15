QuakeWatch Phase 3 - Kubernetes, Helm, and CI/CD
Objective

Phase 3 focuses on automating deployment and improving version control.
You will find a Helm chart for the QuakeWatch application, a Git repository with branching strategy, and a CI/CD pipeline using GitHub Actions.

Repository Structure
.
├── app.py                 # Flask web application
├── Dockerfile             # Docker image definition
├── docker-compose.yml     # Optional local Docker Compose setup
├── requirements.txt       # Python dependencies (Flask, Pylint)
├── README.md
├── .github/workflows/
│   └── ci-cd.yaml         # GitHub Actions workflow
├── deployment.yaml         # Kubernetes Deployment
├── service.yaml            # Kubernetes Service
├── hpa.yaml                # Horizontal Pod Autoscaler
├── configmap.yaml          # ConfigMap for environment variables
├── secret.yaml             # Secret for sensitive data
├── cronjob.yaml            # CronJob for periodic tasks
└── quakewatch/             # Helm chart folder

Prerequisites

Docker

Minikube

kubectl

Helm

Git

Local Deployment (Minikube)

Start Minikube

minikube start


Set Docker environment to Minikube

minikube docker-env | Invoke-Expression


Build Docker image

docker build -t quakewatch:latest .


Deploy Kubernetes resources

kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
kubectl apply -f cronjob.yaml


Access the application

minikube service quakewatch-service


Check Horizontal Pod Autoscaler

kubectl get hpa

Helm Deployment

Navigate to the Helm chart folder:

cd quakewatch


Install or upgrade the release:

helm upgrade --install quakewatch .

Git & CI/CD

Branches

main — stable version

develop — development branch

Workflow

Located in .github/workflows/ci-cd.yaml

Runs on push or pull request to main or develop

Steps:

Checkout code

Set up Python (3.10 and 3.11)

Install dependencies (requirements.txt)

Run Pylint for linting

Note: Deployment to Kubernetes is done locally with Minikube. GitHub Actions runs Lint & Test.

Notes

Ensure Docker image is built inside Minikube to avoid pull issues.

Adjust replicas, CPU targets, and CronJob schedule as needed.

Use kubectl logs and kubectl describe for debugging pods.

Deliverables

Helm chart: quakewatch/ folder

Git repository with branching and workflow

CI/CD pipeline: .github/workflows/ci-cd.yaml

Local Kubernetes deployment (Minikube)
