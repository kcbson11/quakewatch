# QuakeWatch – GitOps Deployment & Monitoring (Phases 3–4)

## 🌋 Overview
**QuakeWatch** is a Kubernetes-based application deployed and managed through **Argo CD (GitOps)**.  
It is monitored using **Prometheus**, **Grafana**, and **Blackbox Exporter** to ensure continuous availability and performance visibility.

This documentation covers:
- GitOps deployment workflow using Argo CD
- Prometheus and Grafana setup
- Custom HTTP probe and alerting configuration
- Example dashboards and alerting behavior

---

## ⚙️ Phase 3 – GitOps with Argo CD

### 1. Overview
The application is managed declaratively using Argo CD.  
Argo CD watches this repository and ensures the deployed state matches the configuration stored in Git.

### 2. Workflow
- The Helm chart for QuakeWatch is located in the `quakewatch/` folder.  
- Argo CD automatically syncs any changes pushed to the `main` branch.  
- Automated policies (`selfHeal` and `prune`) ensure that configuration drift is corrected and deleted resources are removed.

### 3. Deployment Steps
- Apply the Argo CD Application manifest:
kubectl apply -n argocd -f argocd-quakewatch.yaml

diff
Copy code
- Verify synchronization:
kubectl get applications -n argocd

yaml
Copy code
The application should show as **Synced** and **Healthy**.

---

## 📊 Phase 4 – Monitoring with Prometheus & Grafana

### 1. Monitoring Stack Installation
Prometheus and Grafana are deployed using the `kube-prometheus-stack` Helm chart.  
This stack provides:
- Prometheus for metrics collection  
- Grafana for visualization  
- Node and service exporters for cluster insights  

Installation command:
helm install monitoring prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace

yaml
Copy code

### 2. Accessing the Interfaces
| Service | Command | URL |
|----------|----------|-----|
| Grafana | `kubectl -n monitoring port-forward svc/monitoring-grafana 3000:80` | http://localhost:3000 |
| Prometheus | `kubectl -n monitoring port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090` | http://localhost:9090 |

Grafana default credentials:  
- **Username:** `admin`  
- **Password:** `prom-operator` (or retrieved from Kubernetes secret)

---

## 🌐 Blackbox HTTP Probe
The **Blackbox Exporter** is used to monitor the external availability of the QuakeWatch service.  
It probes the internal service endpoint:
http://quakewatch-service.quakewatch-test.svc.cluster.local/

yaml
Copy code
Prometheus regularly checks this URL and reports success or failure.  
A successful probe means the application is responding correctly (status 200).

In Prometheus → *Status → Targets*, the probe appears as:  
`probe/monitoring/quakewatch-http` = **UP (5/5 targets)**

---

## 🚨 Alerting
Custom Prometheus alert rules were created to monitor:
1. **Service Availability:**  
   - Triggered when the HTTP probe fails for 2 minutes.  
   - Alert name: `QuakewatchHttpDown`  
   - Severity: Critical  

2. **Pod Restarts:**  
   - Triggered when a container restarts more than 3 times in 5 minutes.  
   - Alert name: `HighPodRestarts`  
   - Severity: Warning  

You can view these alerts in the Prometheus UI under the *Alerts* tab.

---

## 📈 Grafana Dashboard –
A custom Grafana dashboard was created to visualize application availability and latency.

**Dashboard panels:**
1. **Stat panel:** Displays `probe_success{job="quakewatch-http"}`  
   - Shows if the service is up (1) or down (0).
2. **Time series panel:** Displays `probe_duration_seconds{job="quakewatch-http"}`  
   - Visualizes HTTP response time over time.

Additionally, standard dashboards were imported:
- **315** – Kubernetes Cluster Monitoring  
- **8588** – Node Exporter Full  
- **1860** – Prometheus 2.0 Overview  

## 🧾 Summary of Components
| Component | Purpose |
|------------|----------|
| **Argo CD** | Automates deployment from Git using GitOps principles |
| **Helm Chart** | Defines Kubernetes resources for the QuakeWatch app |
| **Prometheus** | Collects and stores metrics for system performance |
| **Grafana** | Displays dashboards and visual metrics |
| **Blackbox Exporter** | Probes HTTP endpoints for availability |
| **PrometheusRules** | Defines alerting conditions for uptime and restarts |

---

## 🧰 Useful Commands
```bash
kubectl get applications -n argocd
kubectl get pods -n quakewatch-test
kubectl get prometheusrules -n monitoring
kubectl get servicemonitor -n monitoring
kubectl port-forward -n monitoring svc/monitoring-grafana 3000:80
kubectl port-forward -n monitoring svc/monitoring-kube-prometheus-prometheus 9090:9090

Repository: https://github.com/kcbson11/quakewatch
Author: [Your Name]
Date: October 2025
