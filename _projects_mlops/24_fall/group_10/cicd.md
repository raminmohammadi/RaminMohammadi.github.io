---
title: "7. CI/CD"
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

The continuous integration and continuous deployment (CI/CD) pipeline ensures that updates to Medify AI's **frontend and backend** are **tested, containerized, and deployed automatically**. This reduces manual work, ensures stability, and allows faster improvements to the system.  

## 1. Deployment

<iframe src="https://www.youtube.com/embed/6j9V9x5tGJM" width="640" height="360" frameborder="0" allowfullscreen></iframe>

### Why is CI/CD important in Medify AI?  

- Ensures **new features and fixes** reach users quickly  
- Reduces **manual deployment errors**  
- Maintains a **consistent and reliable system**  
- Provides **automated monitoring** and rollback in case of issues  

## 2. CI/CD Pipeline Structure  

Below is the **automated deployment pipeline** used for Medify AI.  

### 2.1 How does this pipeline work?  

1. **Developers push changes** to the GitHub repository  
2. **GitHub Actions runs tests** to ensure no errors are introduced  
3. **Docker images are built** and pushed to Amazon Elastic Container Registry (ECR)  
4. **AWS EKS (Kubernetes)** deploys the new version automatically  
5. **CloudWatch and Prometheus** monitor system health  
6. **A notification** is sent when deployment is complete  

This automated process allows Medify AI to **update quickly and reliably** without manual intervention.  

## 3. CI/CD Execution Flow  

### 3.1 Continuous Deployment Execution  

The following image shows the **pipeline execution**, with **parallel frontend and backend deployment**, followed by the **notify-deployment** step.  

![CI/CD Execution Flow](/images/Projects/mlops/24_fall/group_10/9.webp)  

## 4. Frontend Deployment  

### 4.1 What is the frontend?  

The frontend is the **user interface** of Medify AI. It allows patients and doctors to interact with the system through a **web application**.  

### 4.2 How is the frontend deployed?  

Below is the automated deployment process for the frontend.  

![Frontend Deployment](/images/Projects/mlops/24_fall/group_10/10.webp)  

#### Steps in Frontend Deployment  

1. **Checkout code** – Fetches the latest frontend changes  
2. **AWS authentication** – Ensures secure cloud access  
3. **Build and push image** – Packages the frontend into a Docker container  
4. **Deploy to AWS EKS** – Updates the frontend running on AWS  
5. **Start the service** – Ensures the frontend is live  
6. **Post deployment checks** – Confirms everything is working  

This automation ensures that **whenever developers update the frontend**, users **immediately see the latest version**.  

## 5. Backend Deployment  

### 5.1 What is the backend?  

The backend processes **user requests, runs AI models, and manages data storage**. It ensures that **patient records, chatbot responses, and medical recommendations** are handled efficiently.  

### 5.2 How is the backend deployed?  

The backend follows a similar deployment process to the frontend.  

![Backend Deployment](/images/Projects/mlops/24_fall/group_10/11.webp)

#### Steps in Backend Deployment  

1. **Checkout code** – Fetches the latest backend updates  
2. **AWS authentication** – Grants secure cloud access  
3. **Build and push backend image** – Packages the backend into a Docker container  
4. **Deploy to AWS EKS** – Updates backend services on AWS  
5. **Start backend services** – Ensures APIs and AI models run correctly  
6. **Post deployment validation** – Checks that backend is functioning properly  

By automating backend deployment, Medify AI ensures that **API updates, AI improvements, and data processing enhancements** are available to users **without downtime**.  

## 6. Deployment Notifications  

After deploying the **frontend and backend**, the system **notifies the team** that the update was successful.  

### 6.1 Why are deployment notifications important?  

- Keeps the team informed about **successful or failed deployments**  
- Helps developers **debug issues quickly**  
- Ensures that **no changes go unnoticed**  

### 6.2 How does notification work?  

Once the system confirms that deployment is successful, it sends a **notification** via Slack, Email, or AWS SNS.  

![Deployment Notification](/images/Projects/mlops/24_fall/group_10/12.webp)  

## 7. Key Benefits of CI/CD in Medify AI  

1. **Faster Updates** – New features and fixes are deployed quickly  
2. **Automated Testing** – Catches issues before they affect users  
3. **Zero Downtime Deployments** – Ensures system availability  
4. **Scalability** – Supports cloud-based growth  
5. **Monitoring and Alerts** – Tracks system health and prevents failures  

## 8. Conclusion  

The CI/CD pipeline in Medify AI ensures **automated, reliable, and scalable deployment**.  

- The **frontend and backend** are updated **seamlessly**  
- **Testing and monitoring** guarantee system stability  
- **Automatic rollback** prevents issues from affecting users  

This system allows Medify AI to **continuously improve** while maintaining a **stable and user-friendly experience** for patients and doctors.  

### References: 

- [Workflow configuration for CI/CD](https://github.com/deepaku23/MedifyAI/tree/main/.github/workflows)