---
title: "5. Deployment"
featured_image: '/images/Projects/mlops/24_fall/group_10/cover.webp'
--- 

## Table of Contents

1. [Introduction]({% link _projects/mlops/2024-01-01-f24-group-10.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/24_fall/group_10/scoping.md %} ){:target="_blank"}<br>
3. [Data Pipeline]( {% link _projects_mlops/24_fall/group_10/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/24_fall/group_10/modelling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/24_fall/group_10/deployment.md %} ){:target="_blank"}<br>
6. [AWS Deployment Setup]( {% link _projects_mlops/24_fall/group_10/aws-deployment-setup.md %} ){:target="_blank"}<br>
7. [CI/CD]( {% link _projects_mlops/24_fall/group_10/cicd.md %} ){:target="_blank"}<br>
8. [Monitoring]( {% link _projects_mlops/24_fall/group_10/monitoring.md %} ){:target="_blank"}<br>

## 1. Introduction

**MedifyAI** is a cloud-native solution designed for scalable, reliable, and secure medical symptom analysis. This document outlines the deployment strategy, highlighting the use of AWS services and the architectural decisions that ensure high availability and scalability.

## 2. Cloud Infrastructure Overview

### 2.1 Deployment Environment: Cloud-Based Solution

**MedifyAI** leverages AWS's suite of services to create a robust architecture. The core services include:

- **Amazon S3** for storing datasets and artifacts, ensuring scalable and secure data management.
- **Amazon SageMaker** for managing MLflow experiment tracking and model registry, simplifying the deployment and management of machine learning models.
- **Amazon EKS** for Kubernetes cluster management, enabling efficient orchestration and scaling of application components.
- **AWS Lambda** for automating data processing workflows, providing event-driven execution without manual intervention.
- **Amazon EC2** for compute instances, supporting application hosting with flexible resource allocation.
- **Amazon CloudWatch** for centralized logging and system monitoring, offering insights into system health and performance metrics.

This architecture ensures high availability, scalability, and security, forming the foundation of our healthcare analytics system.

## 3. Kubernetes Infrastructure and Deployment Architecture

### 3.1 Overview
The **MedifyAI** application is deployed on Amazon EKS, implementing a scalable microservices architecture. This setup ensures high availability and zero-downtime deployments.

### 3.2 Container Registry and Image Management

![ECR](/images/Projects/mlops/24_fall/group_10/2.webp)

Amazon ECR is used for secure image management, supporting our continuous deployment pipeline.

### 3.3 Elastic Kubernetes Cluster (EKS)

![EKS](/images/Projects/mlops/24_fall/group_10/3.webp)

The EKS cluster is designed for performance and cost-efficiency, using c4.xlarge instances with elastic scaling.

### 3.4 Pods Distribution

![Pods](/images/Projects/mlops/24_fall/group_10/4.webp)

The cluster orchestrates 14 pods, ensuring high availability and zero-downtime deployments.

### 3.5 Service Architecture and Network Communication

Kubernetes Services provide stable networking interfaces, ensuring secure internal communication and external accessibility.

### 3.6 Load Balancing Strategy

![Load Balancing](/images/Projects/mlops/24_fall/group_10/5.webp)

AWS Network Load Balancers ensure optimal traffic distribution and high availability.

### 3.7 Monitoring and Observability
The deployment includes CloudWatch, Fluent Bit, and Grafana for comprehensive monitoring and observability.

### 3.8 Conclusion
Our Kubernetes infrastructure balances scalability, reliability, and operational efficiency, supporting our healthcare application's demanding requirements.

## 4. Automated Data Processing with AWS Lambda

### 4.1 Overview
AWS Lambda automates data processing workflows, ensuring continuous updates to our medical analysis system.

### 4.2 Lambda Function Implementation
The Lambda function monitors S3 for new data, triggering our Airflow DAG for data processing.

### 4.3 Data Processing Workflow

![DAG Run](/images/Projects/mlops/24_fall/group_10/6.webp)

The workflow includes data preprocessing, statistical analysis, and vector database integration.

### 4.4 Security and Monitoring
Lambda adheres to AWS security best practices, with activities monitored through CloudWatch.

### 4.5 Conclusion
AWS Lambda provides an efficient, automated approach to handling medical data updates, maintaining high standards of data processing and security.

## 5. Amazon SageMaker

### 5.1 Overview
Amazon SageMaker is used for model serving and experiment tracking, supporting our medical analysis pipeline.

### 5.2 Model Deployment Strategy

![Endpoint](/images/Projects/mlops/24_fall/group_10/7.webp)

OpenBioLLM is deployed through SageMaker's managed endpoints, ensuring responsive model serving.

### 5.3 Model Versioning and Tracking

![MLFlow](/images/Projects/mlops/24_fall/group_10/8.webp)

MLflow integration enables comprehensive experiment tracking and model versioning.

### References: 
- [More details on Deployment](https://github.com/deepaku23/MedifyAI/blob/main/docs/README.md)