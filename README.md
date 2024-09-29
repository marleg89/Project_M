
# DevOps Project_M: Web Application Deployment in DevOps workflow

## Introduction

This project demonstrates a complete DevOps pipeline for automating the deployment of a Flask web application in a Kubernetes environment. The goal is to showcase the integration of modern DevOps concept like CI/CD, Containerization, IaC, GitOps, Cloud environment...

Key principles of DevOps philosophy are at the core of this project, such as idempotency, automation, and Infrastructure as Code. Future improvements will focus on ensuring availability and security.

## Technologies and Tools

- **GitHub Actions**: Used to create a CI/CD pipeline to test and build the Flask application into a Docker image.
- **Docker**: Containerization of the Flask application for maximum portability.
- **Terraform**: Used to provision virtual machines (VMs) via **Libvirt** to host the Kubernetes cluster.
- **Ansible**: Automation of node setup (installing and configuring Nodes, Kubernetes, and ArgoCD).
- **Kubernetes**: Container orchestration within a cluster.
- **ArgoCD**: GitOps-based synchronization and deployment of Kubernetes manifests from a Git repository.

## Architecture Overview

![Schema](./images/workflow.svg)

1. **CI**: The pipeline is triggered on every push to the GitHub repository, running:
   - Unit tests to validate the Flask app.
   - Docker image build and push to DockerHub (or private Docker registry).

2. **CD**: Provisions 5 virtual machines using Libvirt on the self hosted runner. These VMs are bridged to the local network:
   - 1 Kubernetes control plane node.
   - 4 Kubernetes worker nodes.

3. **Provisioning**: After VMs are created, Ansible:
   - Set up nodes for following tasks
   - Installs and configures Kubernetes on the nodes.
   - Installs ArgoCD.

5. **ArgoCD**: After installation, ArgoCD manages the application deployment:
   - The Flask app is deployed using **Kubernetes manifests** (YAML files) synchronized directly from the Git repository via ArgoCD.
   - Any updates to the manifests in the Git repository automatically update the application in the Kubernetes cluster.

## Future Improvements

This project is a solid foundation for future enhancements, including:
- **Deployment in a hybrid cloud environment**.
- **Multi-cluster support** (using KubeFed, Rancher, Openshift, etc.).
- **High Availability (HA) setup** for fault tolerance.
- **Secret management** using Vault.
- **Enhanced monitoring** with Prometheus, Grafana, and Loki for logging.
- **Service discovery and service mesh** integration.
- **DNS, DHCP, VPN and load-balancing** setup for better connectivity and resilience.

## Requirements

The following elements are mendatory on the self hosted runner:
- Linux based system (Only tested on debian 12) - kernel: 6.1.0-23-amd64 or higher
- Libvirt version: 9.0.0
- qemu version: 7.2.11
- Terraform v1.9.6 or higher
- Ansible 2.16.11 or higher
- Git LFS 3.5.1 
- Self hosted GitHub runner


---

Feel free to explore the repository and provide feedback!

