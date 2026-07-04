# Cost

This project extends the previous Docker Compose and Portainer deployment by introducing a highly available Kubernetes platform. While the infrastructure cost is higher than a single-server deployment, the additional investment provides improved reliability, scalability, automation, and resilience.

## Monthly Itemized Cost

| Item                             | Spec                           | Qty |   Estimated Cost (USD/month) |
| -------------------------------- | ------------------------------ | --: | ---------------------------: |
| Control Plane VM                 | EC2 t3.small                   |   1 |                          $15 |
| Worker VMs                       | EC2 t3.small                   |   2 |                          $30 |
| Elastic IP                       | Public IP                      |   1 |                           $3 |
| Block Storage                    | EBS Volumes (20 GB each)       |   3 |                           $6 |
| Object Storage                   | S3 (Terraform State & Backups) |   1 |                 Less than $1 |
| DynamoDB                         | Terraform State Locking        |   1 |                 Less than $1 |
| DNS / Domain                     | Route 53 Hosted Zone / Domain  |   1 |             Approximately $1 |
| **Total Estimated Monthly Cost** |                                |     | **Approximately $55–60 USD** |

---

## Compared to the Single-Server Compose + Portainer Deployment

The previous Docker Compose deployment required only a single virtual machine, making it inexpensive to operate. The estimated monthly infrastructure cost was approximately **$15–20 USD**.

The Kubernetes platform increases the monthly cost to approximately **$55–60 USD** because multiple virtual machines are required to provide high availability and redundancy.

The additional cost provides several important benefits:

* High Availability through multiple worker nodes.
* Automatic pod rescheduling if a node fails.
* Horizontal Pod Autoscaling to respond to increased workload.
* Rolling updates with zero downtime.
* Persistent storage using Kubernetes StatefulSets and Persistent Volume Claims.
* Automated deployments using GitOps (Argo CD).
* Improved security through Network Policies, Secrets, and TLS certificates.
* Better scalability compared to a single-server deployment.

For small personal projects or low-traffic applications, this additional cost may not be justified. However, for production workloads where availability, scalability, and reliability are important, the additional investment is worthwhile.

---

## How I Would Reduce the Cost by Half

If this environment were used for development or testing instead of production, I would reduce costs by replacing the EC2 instances with smaller instance types such as **t3.micro** where appropriate. I would also schedule non-production instances to shut down automatically outside working hours, reducing compute costs significantly. Spot Instances could be used for worker nodes to lower operating expenses further. Storage allocation could also be reduced to match actual application requirements. These optimizations would lower the monthly operating cost while still maintaining a functional Kubernetes environment for development and learning purposes.
