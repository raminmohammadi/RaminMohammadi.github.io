---
title: "2. Scoping"
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

## 1. Overview

**MedifyAI** is an AI-driven healthcare analytics system for medical symptom analysis and case-based diagnosis. It integrates conversational AI, retrieval-augmented generation (RAG), and cloud-based MLOps to assist healthcare professionals. 

The system is built on the [PMC-Patients Dataset](https://huggingface.co/datasets/zhengyun21/PMC-Patients), which includes 167,034 anonymized patient summaries extracted from PubMed Central.

## 2. Problem Statement

Healthcare systems often lack structured patient symptom collection and real-time medical assistance. Doctors rely on incomplete patient histories, leading to diagnostic delays. MedifyAI aims to improve this by enabling structured symptom collection, retrieval-based case comparison, and patient interaction with their medical reports.

## 3. Objectives

1. Improve patient engagement through AI-driven conversation  
2. Provide treatment recommendations using historical medical data  
3. Reduce bias in patient interactions  
4. Monitor retrieval performance and maintain data updates  
5. Deploy a scalable AI solution in a cloud environment  

## 4. Key Features

### 4.1 Medical Chatbot  
- Uses [GPT-3.5](https://platform.openai.com/docs/models#gpt-3-5-turbo) for patient symptom collection  
- Detects emergency situations in real time  
- Generates clinical summaries for doctors  

### 4.2 Medical Case Analysis  
- Uses [sentence-transformers/all-MiniLM-L6-v2](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2)
- Employs [GPT-4](https://openai.com/index/gpt-4/) to analyze retrieved cases  
- Tracks system performance with MLflow  

### 4.3 Patient Report Interaction  
- [Llama3-OpenBioLLM-70B](https://huggingface.co/aaditya/Llama3-OpenBioLLM-70B) ([More Info](https://www.saama.com/introducing-openbiollm-llama3-70b-8b-saamas-ai-research-lab-released-the-most-openly-available-medical-domain-llms-to-date/)) enables question-answering on reports  
- Explains complex medical findings in simple terms  
- Provides context-aware responses for better patient understanding  

## 5. System Workflow

1. The chatbot collects symptoms and creates a structured summary  
2. The system retrieves similar cases from the PMC-Patients dataset  
3. GPT-4 generates a medical summary based on retrieved cases  
4. [Llama3-OpenBioLLM-70B](https://huggingface.co/aaditya/Llama3-OpenBioLLM-70B) ([More Info](https://www.saama.com/introducing-openbiollm-llama3-70b-8b-saamas-ai-research-lab-released-the-most-openly-available-medical-domain-llms-to-date/))  allows patients to interact with their reports  
5. Data processing and storage are handled using [Apache Airflow](https://airflow.apache.org/docs/apache-airflow/stable/)  and [Pinecone](https://www.pinecone.io/)  
6. The system is deployed on AWS EKS, with monitoring via CloudWatch  

## 6. Technical Components

| Component | Technology Used |
|-----------|----------------|
| Cloud Provider | AWS (EKS, Lambda, SageMaker) |
| Data Processing | Apache Airflow |
| Embedding Model | sentence-transformers/all-MiniLM-L6-v2 |
| Language Models | GPT-3.5, GPT-4, OpenBioLLM |
| Vector Database | Pinecone |
| Deployment | Docker, Kubernetes |
| CI/CD | GitHub Actions |
| Monitoring | Prometheus, CloudWatch, Grafana |
| Experiment Tracking | MLflow |

## 7. MLOps Pipeline

The MLOps pipeline automates training, deployment, and monitoring. It consists of:  
1. Data ingestion from [PMC-Patients Dataset](https://huggingface.co/datasets/zhengyun21/PMC-Patients)
2. Embedding generation and storage in [Pinecone](https://www.pinecone.io/)
3. Retrieval and response generation using [GPT-4](https://openai.com/index/gpt-4/)
4. Model deployment through [Amazon SageMaker](https://docs.aws.amazon.com/sagemaker/)  
5. CI/CD automation via [GitHub Actions](https://docs.github.com/en/actions)
6. System monitoring through [Prometheus](https://aws.amazon.com/prometheus/) and [CloudWatch](https://aws.amazon.com/cloudwatch/)

## 8. Challenges and Considerations

1. Addressing bias in chatbot responses across demographics  
2. Improving retrieval accuracy to ensure relevant case recommendations  
3. Managing cloud resource costs and optimizing infrastructure  
4. Ensuring patient data security and regulatory compliance  

## 9. Expected Impact

**MedifyAI** aims to enhance healthcare decision-making by providing structured patient data, assisting doctors with case-based recommendations, and allowing patients to engage with their medical reports. The system is designed to be scalable, efficient, and accessible.
