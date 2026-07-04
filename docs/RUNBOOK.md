# Runbook

This document describes the operational procedures required to provision, deploy, maintain, and recover the Phoenix Kubernetes platform.

---

# Provision From Zero

## Step 1: Provision Infrastructure

```bash
cd infra/terraform

terraform init

terraform plan

terraform apply
```

Terraform provisions:

* VPC
* Public Subnet
* Security Groups
* Control Plane EC2 Instance
* Two Worker EC2 Instances

---

## Step 2: Configure the Kubernetes Cluster

```bash
cd infra/ansible

ansible-playbook -i inventory site.yml
```

This playbook performs the following tasks:

* Updates all servers
* Creates the deployment user
* Configures SSH access
* Installs k3s on the control-plane node
* Joins worker nodes to the cluster
* Retrieves the kubeconfig file

---

## Step 3: Verify Cluster Status

```bash
export KUBECONFIG=./kubeconfig

kubectl get nodes

kubectl get pods -A
```

Expected Result:

* One Ready control-plane node
* Two Ready worker nodes
* All system pods running successfully

---

## Step 4: Install Platform Components

Install Metrics Server:

```bash
kubectl apply -f manifests/metrics-server.yaml
```

Install cert-manager:

```bash
kubectl apply -f manifests/cert-manager.yaml
```

Install Argo CD:

```bash
kubectl apply -f manifests/argocd.yaml
```

Verify:

```bash
kubectl get pods -A
```

---

## Step 5: GitOps Deployment

Deploy the Argo CD Application:

```bash
kubectl apply -f gitops/application.yaml
```

Argo CD continuously monitors the Git repository and automatically synchronizes the Kubernetes cluster with the desired application state.

No manual `kubectl apply` operations are required after GitOps is configured.

---

# Day-2 Operations

## Scale the Backend

Preferred method:

1. Update the Deployment or HorizontalPodAutoscaler manifest in Git.
2. Commit and push the changes.
3. Argo CD automatically synchronizes the cluster.

Example:

```bash
git add .

git commit -m "Increase backend replicas"

git push
```

---

## Roll Back a Deployment

Rollback is performed by reverting the Git commit:

```bash
git revert <commit-id>

git push
```

Argo CD automatically restores the previous working deployment.

---

## Run Database Migrations

Database schema updates are executed using the dedicated Kubernetes Migration Job.

```bash
kubectl apply -f manifests/migration-job.yaml
```

Application containers do not execute migrations during startup, preventing migration conflicts between multiple replicas.

---

## Rotate Secrets

Update the Kubernetes Secret:

```bash
kubectl apply -f manifests/secret.yaml
```

Restart the affected Deployment:

```bash
kubectl rollout restart deployment taskapp-backend
```

---

# Failure Recovery

## Worker Node Failure

If a worker node becomes unavailable:

* Kubernetes automatically detects the node failure.
* Running Pods are rescheduled to healthy worker nodes.
* Services remain available through Kubernetes networking.

For planned maintenance:

```bash
kubectl drain <node-name> --ignore-daemonsets --delete-emptydir-data
```

After maintenance:

```bash
kubectl uncordon <node-name>
```

Expected recovery time is typically a few minutes, depending on workload startup time.

---

## Backend Pod CrashLoopBackOff

Diagnosis:

```bash
kubectl get pods

kubectl describe pod <pod-name>

kubectl logs <pod-name> --previous

kubectl get events
```

Correct the configuration or image issue, commit the fix, and allow Argo CD to synchronize the updated deployment.

---

## Failed Database Migration

If a migration fails:

1. Review the Migration Job logs.
2. Correct the migration script.
3. Commit the fix.
4. Re-run the Migration Job.

This approach prevents multiple backend replicas from applying the same migration concurrently.

---

## PostgreSQL Pod Rescheduling

Delete the PostgreSQL Pod:

```bash
kubectl delete pod postgres-0
```

The StatefulSet automatically recreates the Pod and reattaches the existing Persistent Volume Claim.

Verify that the application data remains available after the Pod has been recreated.

---

# Operational Verification

The deployment is considered healthy when:

* All Kubernetes nodes report **Ready**.
* Frontend and backend Pods are running.
* PostgreSQL is running with persistent storage attached.
* HTTPS is active using a valid Let's Encrypt certificate.
* Argo CD reports the application as **Healthy** and **Synced**.
* Horizontal Pod Autoscaler is functioning as configured.
