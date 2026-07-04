# Phoenix Capstone – TaskApp on Real Kubernetes

## Project Overview

Phoenix is a production-style Kubernetes deployment of the TaskApp application. The project demonstrates how to provision cloud infrastructure using Terraform, configure a multi-node Kubernetes cluster with Ansible, deploy containerized applications using Kubernetes manifests, and manage deployments through GitOps with Argo CD.

Unlike the previous Docker Compose deployment, this project provides high availability, automated scaling, persistent storage, secure HTTPS communication, and automated reconciliation using GitOps.

---

## Objectives

This project demonstrates:

- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- Multi-node Kubernetes (k3s)
- GitOps with Argo CD
- High Availability
- Zero-downtime deployments
- Persistent storage using StatefulSets
- Automatic TLS with Let's Encrypt
- Horizontal Pod Autoscaling
- Kubernetes Networking and Security

---

# Architecture

The platform consists of:

- AWS Infrastructure
- One Kubernetes Control Plane
- Two Kubernetes Worker Nodes
- React Frontend
- Flask Backend
- PostgreSQL StatefulSet
- Persistent Volume Claim
- Ingress Controller
- cert-manager
- Metrics Server
- Argo CD

Request Flow:

```
Internet
      │
      ▼
DNS
      │
      ▼
Ingress Controller
      │
      ▼
Frontend Service
      │
      ▼
Backend Service
      │
      ▼
PostgreSQL StatefulSet
```

For the complete architecture documentation, see:

```
docs/ARCHITECTURE.md
```

---

# Features

✅ Multi-node Kubernetes Cluster

✅ Infrastructure as Code using Terraform

✅ Configuration Management using Ansible

✅ GitOps Continuous Deployment using Argo CD

✅ React Frontend Deployment

✅ Flask Backend Deployment

✅ PostgreSQL StatefulSet

✅ Persistent Volume Claims

✅ ConfigMaps

✅ Kubernetes Secrets

✅ Liveness, Readiness and Startup Probes

✅ Resource Requests and Limits

✅ Rolling Updates

✅ Horizontal Pod Autoscaler (HPA)

✅ Network Policies

✅ Pod Disruption Budget

✅ Automatic HTTPS using Let's Encrypt

✅ Metrics Server

---

# Technologies Used

| Technology | Purpose |
|------------|---------|
| Terraform | Infrastructure Provisioning |
| AWS EC2 | Cloud Infrastructure |
| Ansible | Server Configuration |
| Kubernetes (k3s) | Container Orchestration |
| Docker | Containerization |
| GitHub Actions | CI/CD |
| Argo CD | GitOps |
| React | Frontend |
| Flask | Backend |
| PostgreSQL | Database |
| NGINX / Traefik | Ingress |
| cert-manager | TLS Certificates |
| Let's Encrypt | SSL Certificates |

---

# Repository Structure

```
capstone-phoenix/

├── docs/
│   ├── ARCHITECTURE.md
│   ├── RUNBOOK.md
│   ├── COST.md
│   └── EVIDENCE/
│
├── infra/
│   ├── terraform/
│   └── ansible/
│
├── manifests/
│
├── gitops/
│
├── .github/
│   └── workflows/
│
├── README.md
│
└── STRUCTURE.md
```

---

# Deployment

## Provision Infrastructure

```bash
cd infra/terraform

terraform init

terraform plan

terraform apply
```

---

## Configure Kubernetes Cluster

```bash
cd infra/ansible

ansible-playbook -i inventory site.yml
```

---

## Verify Cluster

```bash
kubectl get nodes

kubectl get pods -A
```

---

## Deploy Platform Components

Install:

- Metrics Server
- cert-manager
- Argo CD

---

## Deploy Application

Commit Kubernetes manifests to GitHub.

Argo CD automatically synchronizes the cluster with the Git repository.

---

# Screenshots

## Kubernetes Platform

> Replace the placeholder below with your architecture diagram.

![Architecture](docs/EVIDENCE/running-kubernetes.png)

---

## Multi-node Cluster

![Nodes Ready](docs/EVIDENCE/nodes-ready.png)

---

## Pods Running

![Pods](docs/EVIDENCE/pods-spread.png)

---

## Argo CD

![Argo CD](docs/EVIDENCE/argocd-synced.png)

---

## TLS Certificate

![TLS](docs/EVIDENCE/tls-valid.png)

---

# Documentation

Additional documentation is available in:

- docs/ARCHITECTURE.md
- docs/RUNBOOK.md
- docs/COST.md
- docs/EVIDENCE/

---

# Security

This project follows security best practices including:

- Least privilege firewall configuration
- Kubernetes Secrets
- ConfigMaps
- TLS encryption
- Network Policies
- GitOps deployment model
- Infrastructure as Code

---

# Future Improvements

- Prometheus and Grafana monitoring
- External Secrets
- Automated PostgreSQL backups
- Multi-region deployment
- Managed Kubernetes control plane
- Disaster recovery automation

---

# Author

**Name:** Stanley Ozichi

GitHub:

https://github.com/Stan1712

---

# License

This project was completed as part of the **Phoenix Kubernetes Capstone Project** for educational purposes.