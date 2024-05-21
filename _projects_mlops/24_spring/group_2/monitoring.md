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

## MLFlow Overview in Test Environment

MLFlow is an integral part of our MLOps pipeline, providing model versioning, management, and serving capabilities. This document outlines the key aspects of MLFlow operations within the test environment, detailing version controls, artifact handling, and how to utilize the models within the Databricks environment.

## Registered Models in Test Environment

Our MLFlow setup includes several versions of the model, with detailed tracking of experiments and model performance metrics.

![model version](/images/Projects/mlops/24_spring/group_2/image_10.webp)

### About Version 7
Version 7 of the model is currently in the ready state and is serving predictions. This model incorporates improvements over previous versions and includes comprehensive logging of input and output schemas as well as detailed artifact storage.

![model version 7](/images/Projects/mlops/24_spring/group_2/image_11.webp)

### Previous Versions
Version 6, which was active before Version 7, is also documented to provide insights into the model's evolution and basis for improvements.

![model version 6](/images/Projects/mlops/24_spring/group_2/image_12.webp)

## Artifacts and MLmodel File

The artifacts stored in MLFlow provide a detailed breakdown of the model components. The MLmodel file is a key artifact that outlines the model configuration, dependencies, and the environment setup required to run the model. 

Artifacts details are shown below:

![model artifacts](/images/Projects/mlops/24_spring/group_2/image_13.webp)

Overall details of Model Schema, MLFlow Model is shown:

![model artifacts](/images/Projects/mlops/24_spring/group_2/image_14.webp)

## Prod Environment Overview

In the production environment, model versioning and management follow a streamlined process tailored for operational stability and performance. This section outlines how models are handled in production within our MLOps setup using MLFlow.

## Models in Production

Once the production models are fully operational, they serve the advanced functionalities of a chatbot, which is a significant component of our service offerings. The models in production are managed with distinct versioning practices to ensure stability and traceability.

## Model Registry and Versioning

Model versioning in production is handled through the MLFlow model registry, where each model version is meticulously documented and stored. Below are the details of a typical model setup in production:

## Training and Artifacts

Each model version in production is linked to a specific training run, allowing us to trace back to the experimental setups and configurations. This traceability ensures that any deployed model can be audited and validated against its training parameters and outcomes.
- **Training Run**: dbdemos_chatbot_rag
- **Artifact Path**: This path provides access to all relevant artifacts associated with the model, including the MLmodel configuration files, environmental dependencies, and the actual model data.

## Accessing and Managing Models

To access and manage the deployed models in production:
1. Navigate to the MLFlow model registry via the Databricks workspace.
2. Select the `dbdemos_advanced_chatbot_model` to view all versions and their details.
3. Each model version can be examined for its input and output signatures, artifacts, and the exact time of creation and last modification.

## Model Version Rollback

To revert to a prior version of a model in a production environment, you can follow the procedure outlined below:

### Step 1: Navigate to the Serving Section
Access the "Serving" section via the left sidebar in Databricks, which displays a list of all active serving endpoints.

![model versions](/images/Projects/mlops/24_spring/group_2/image_15.webp)

### Step 2: Select the Deployed Model
Identify and select the model currently deployed in production. This will present you with a screen similar to the following:

![deployed model](/images/Projects/mlops/24_spring/group_2/image_16.webp)

### Step 3: Edit Endpoint
In the upper-right corner, click on "Edit endpoint". Within this area, locate the "Served entities" section, which includes a version dropdown menu. This menu allows you to view and select from previously deployed model versions. Choose the desired version and confirm the rollback by clicking "Update".

![edit model endpoint](/images/Projects/mlops/24_spring/group_2/image_17.webp)

## Inference Table Analysis using Databricks Lakehouse Monitoring

Inference Table Analysis using Databricks Lakehouse Monitoring
Databricks Lakehouse Monitoring automatically builds a dashboard to track your metrics and their evolution over time. We have manually built other visualizations, here are some of them.

Here we are creating a job scheduling trigger, which will trigger our inference tables every 5 minutes, which generates the evaluation matrices that are being used for further in-depth analysis.

![Inference Table Analysis](/images/Projects/mlops/24_spring/group_2/image_18.webp)

![Inference Table Analysis](/images/Projects/mlops/24_spring/group_2/image_19.webp)

These three pie charts represent metrics assessing changes over time between two versions of a model: an older version (indicated in blue) and the latest version (shown in yellow). The metrics presented are average perplexity, Flesch-Kincaid readability index, and toxicity level. The color coding suggests that the newer version of the model shows improvements (less) compared to the older version (more).

The interpretation of these charts can be instrumental in evaluating the evolution of the model in terms of complexity, readability, and safety. A decrease in perplexity may indicate that the model's predictions have become more predictable or contextually appropriate, which can enhance user satisfaction. Improvements in the Flesch-Kincaid readability score suggest that the text generated by the model is easier to read and understand, making it more accessible to a broader audience. A reduction in toxicity levels is critical, as it reflects a safer interaction environment for users, minimizing the risk of generating harmful or inappropriate content.

These metrics not only demonstrate the model's enhancement in generating more user-friendly and ethical content but also serve as indicators of the overall health and security of the system. Monitoring these changes can help in early detection of anomalies that might indicate potential security breaches or degradation in user experience.

![Inference Table Analysis](/images/Projects/mlops/24_spring/group_2/image_20.webp)

As you can see below, the graphs show the line chart for prompts used by the users versus the toxicity score. This can help us to generate flags for toxic inputs and do further prompt engineering to make the bot more ethical and user-friendly. 

![Inference Table Analysis](/images/Projects/mlops/24_spring/group_2/image_21.webp)

This graph shows the token output by our model over time, this helps to see flags and also for cost tracking. This graph can be further analyzed by tracking the usage over a specific period of time. This helps to solve the latency issue.

![image](/images/Projects/mlops/24_spring/group_2/image_27.webp)

Here you can see the Flesh Kincaid score for every minute the model is being used in the month of April. This score is for checking the readability of the model. For understanding the metric better, [refer](https://mlflow.org/docs/latest/python_api/mlflow.metrics.html#mlflow.metrics.flesch_kincaid_grade_level).

![image](/images/Projects/mlops/24_spring/group_2/image_28.webp)