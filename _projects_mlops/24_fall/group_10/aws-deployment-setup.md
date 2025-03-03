---
title: "6. AWS Deployment Setup"
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


### 1. Prerequisites

To replicate the deployment, ensure the following prerequisites are met:

1. **AWS Account and CLI Configuration**: Install and configure the AWS CLI to interact with AWS services.
   ```bash
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
   unzip awscliv2.zip
   sudo ./aws/install
   aws configure
   ```

2. **Required Tools Installation**: Install Docker, kubectl, and eksctl for container management and Kubernetes operations.
   ```bash
   sudo apt-get update
   sudo apt-get install docker.io
   sudo usermod -aG docker $USER
   curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
   sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
   curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
   sudo mv /tmp/eksctl /usr/local/bin
   ```

### 2. Infrastructure Setup

1. **Create EKS Cluster**: Set up a Kubernetes cluster using eksctl, which manages the orchestration of containerized applications.
   ```bash
   eksctl create cluster \
       --name patient-insight-eks-cluster \
       --region us-east-2 \
       --node-type c4.xlarge \
       --nodes-min 2 \
       --nodes-max 4 \
       --with-oidc \
       --ssh-access \
       --ssh-public-key your-key-name \
       --managed
   ```

2. **Create ECR Repositories**: Establish repositories for frontend and backend components to manage Docker images.
   ```bash
   aws ecr create-repository --repository-name frontend
   aws ecr create-repository --repository-name backend
   ```

### 3. Application Deployment

1. **Clone Repository**: Download the project repository and navigate to the project directory.
   ```bash
   git clone https://github.com/your-repo/PatientInsight.git
   cd PatientInsight
   ```

2. **Environment Configuration**: Set up environment variables in a `.env` file to configure the deployment environment.
   ```bash
   AWS_REGION=us-east-2
   OPENAI_API_KEY=your_openai_key
   PINECONE_API_KEY=your_pinecone_key
   AWS_ACCESS_KEY_ID=your_aws_key
   AWS_SECRET_ACCESS_KEY=your_aws_secret
   ```

3. **Automated Deployment**: Execute the deployment script to automate the setup process.
   ```bash
   chmod +x deploy.sh
   ./deploy.sh
   ```

### 4. Validation and Troubleshooting

- **Validation**: The deployment script outputs the status of pods and nodes, along with frontend and backend URLs for application access.
- **Troubleshooting**: Common issues include pod startup problems, service connection issues, and image pull errors. Use `kubectl` commands to diagnose and resolve these issues.

### 5. Cleanup Instructions

To clean up resources, delete services, deployments, and the EKS cluster.
```bash
kubectl delete service frontend-service backend-service
kubectl delete deployment frontend backend
eksctl delete cluster --name patient-insight-eks-cluster --region us-east-2
```

### 6. Security Considerations

- Regularly rotate AWS access keys.
- Use AWS Secrets Manager for sensitive information.
- Implement network policies in EKS.
- Monitor CloudWatch logs for security events.

### References: 
- [More details on the AWS Setup](https://github.com/deepaku23/MedifyAI/blob/main/docs/README.md)