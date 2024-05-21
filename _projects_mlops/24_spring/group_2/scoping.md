---
featured_image: '/images/Projects/mlops/23_fall/group_7/thumbnail.webp'
---

## Outline:

1. [Introduction]({% link _projects/mlops/2024-01-01-s24-group-2.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/24_spring/group_2/scoping.md %} ){:target="_blank"}<br>
3. [Setup on Azure & Databricks]( {% link _projects_mlops/24_spring/group_2/setup.md %} ){:target="_blank"}(Optional)<br>
4. [Data]( {% link _projects_mlops/24_spring/group_2/data.md %} ){:target="_blank"}<br>
5. [Modeling]( {% link _projects_mlops/24_spring/group_2/modeling.md %} ){:target="_blank"}<br>
6. [Deployment]( {% link _projects_mlops/24_spring/group_2/deployment.md %} ){:target="_blank"}<br>
7. [Monitoring]( {% link _projects_mlops/24_spring/group_2/monitoring.md %} ){:target="_blank"}<br>
8. [Cost Analysis]( {% link _projects_mlops/24_spring/group_2/cost.md %} ){:target="_blank"}<br>

This project aims to develop and deploy an advanced chatbot using the Retrieval-Augmented Generation (RAG) model integrated with Azure Databricks. The objective is to enhance the chatbot's ability to provide accurate, relevant, and contextually appropriate responses based on a dynamic knowledge base. Key technologies involved include Delta Tables for efficient data storage, MLFlow for lifecycle management of the RAG model, and serverless architectures to facilitate scalable deployments.

## 1. Dataset Information

- **Data Ingestion:** Data will be sourced primarily from structured and unstructured documents, including PDFs and HTML pages, pertinent to user queries.
- **Data Processing:** Textual data will be segmented, encoded into embeddings, and stored in Delta Tables for optimized retrieval and processing by the RAG model.

## 2. Technical Objectives

- **RAG Integration:** Leverage the Retrieval-Augmented Generation framework to enrich the chatbot’s response mechanism.
- **Data Management:** Use Delta Tables for robust and scalable data handling.
- **Model Management:** Implement MLFlow for tracking, versioning, and managing the RAG model throughout its lifecycle.

## 3. Architecture and Technologies

- **Azure Databricks:** Central platform for model training, data processing, and analytics.
- **Delta Tables:** To ensure **[ACID](https://www.databricks.com/glossary/acid-transactions#:~:text=ACID%20is%20an%20acronym%20that,operations%20are%20called%20transactional%20systems.)** compliance and unify batch and stream processing.
- **MLFlow:** For model development and performance tracking.
- **Serverless Deployment:** Utilize Azure Functions for deploying the RAG model, ensuring cost efficiency and scalability.

## 4. Potential Challenges and Mitigation Strategies

- **Data Security and Compliance:** Ensure all data handling complies with legal standards, including GDPR.
- **System Integration:** Test integrations extensively to prevent disruptions in existing workflows.
- **Cost Management:** Monitor and optimize resource usage to control operational costs effectively.

## 5. Offline Evaluation of our RAG-chatbot

### Step 1: Creating a Superior Model Endpoint

- **External Foundation Model Configuration:** In this step, you configure an external model endpoint using Azure OpenAI. This involves setting up a connection to Azure's services, utilizing their powerful language models (Azure AI GPT-3.5, Mistral-7b, Llama-2, etc.) to enhance our chatbot’s capabilities. This setup provides your chatbot access to state-of-the-art language processing technology, crucial for handling complex queries.
- **Fallback Configuration:** If Azure OpenAI services are unavailable or if there are any issues with the connection or there might be issues when the API key is not stored in secrets, the system automatically switches using a fallback mechanism, using Databricks' managed Llama-2-70b-chat model. This ensures that the chatbot remains functional and continues to deliver responses without interruption. 

### Step 2: Preparing Evaluation Dataset
- The evaluation dataset is stored in Azure Data Lake Storage Gen2 (ADLS Gen2) and is specifically designed for validating the chatbot's responses. This dataset is generated using GPT-4, which crafts a variety of questions that resemble potential real-user inquiries, along with corresponding high-quality answers. These entries are crucial for assessing the chatbot’s ability to handle real-world interactions.

### Step 3: Offline LLM Evaluation

- **Predicting and Storing:** Before deploying the chatbot into a production environment, it undergoes a thorough evaluation. This offline evaluation involves storing the chatbot’s predicted responses against the expert answers provided in the evaluation dataset. This step is critical for ensuring the chatbot can deliver accurate and reliable answers. By comparing the chatbot's responses to expert answers, you can measure its accuracy and make necessary adjustments before live deployment.

### Step 4: LLM as Judge

The evaluation uses various MLflow metrics to assess different aspects of the chatbot's responses:
  - **[Answer Correctness](https://mlflow.org/docs/latest/python_api/mlflow.metrics.html#mlflow.metrics.genai.answer_correctness):** This metric evaluates how accurately the chatbot's responses match the expected answers, which is crucial for user satisfaction and utility.
  This metric is used when you want to evaluate how factually correct the model generated output is based on the information in the ground_truth. High scores mean that your model outputs contain similar information as the ground_truth and that this information is correct, while low scores mean that outputs may disagree with the ground_truth or that the information in the output is incorrect. Note that this builds onto [answer_similarity](https://mlflow.org/docs/latest/llms/llm-evaluate/index.html#:~:text=mlflow.metrics.genai.answer_similarity,disagree%20with%20the%20ground_truth.).
  - **[Toxicity](https://huggingface.co/spaces/evaluate-measurement/toxicity):** It's important to ensure that the chatbot's language remains appropriate and free from harmful content, which this metric assesses. This metric ranges from {0: 'not offensive', 1: 'offensive'}
  - **Readability Scores:** These metrics (such as [Flesch-Kincaid](https://mlflow.org/docs/latest/python_api/mlflow.metrics.html#mlflow.metrics.flesch_kincaid_grade_level) and [ARI](https://en.wikipedia.org/wiki/Automated_readability_index)) assess the complexity of the chatbot’s responses, ensuring they are accessible and understandable to the target audience.
  - **Professionalism:** We are creating a custom metric "professionalism" which ranges from {1: 'very casual', 2: 'casual', 3: 'neutral', 4: 'formal', 5: 'very formal'}. This new metric evaluates the formality and appropriateness of the chatbot's communication style, ensuring it is suitable for its intended professional or formal context.

### Step 5: Model Becomes Production Ready

After thorough testing and validation, and once the model meets all specified criteria, it is finalized for deployment in a production environment. This step marks the readiness of the chatbot to handle real-world tasks and queries. Ensuring the model’s reliability, accuracy, and appropriateness is crucial before it goes live to interact with actual users.
