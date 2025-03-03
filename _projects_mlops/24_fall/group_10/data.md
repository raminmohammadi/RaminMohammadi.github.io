---
title: "3. Data Pipeline for Medify AI"
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

The data pipeline in Medify AI is responsible for processing medical records, transforming raw patient data into a structured format, and ensuring high-quality input for downstream machine learning models. This pipeline automates data collection, preprocessing, and validation to maintain consistency and accuracy.  

A well-designed pipeline is essential for handling large-scale medical data, reducing manual effort, and ensuring real-time updates.  

## 2. Project Repository  

All code for the data pipeline is available in the [Project repository](https://github.com/deepaku23/MedifyAI/tree/main/backend/data_pipeline)

## 3. Folder Structure  

The data pipeline is organized into specific directories for modularity and easy debugging.  

| Directory | Description |
|-----------|------------|
| `backend/data_pipeline/` | Main directory for data pipeline scripts |
| `data/raw/` | Contains raw dataset files |
| `data/processed/` | Stores transformed and cleaned data |
| `scripts/` | Includes code for downloading, preprocessing, and generating statistics |
| `tests/` | Unit tests to validate each step of the pipeline |
| `airflow/` | DAG definitions for automated workflow execution |

## 4. Data Collection  

### 4.1 Why DAGs are Needed  

Directed Acyclic Graphs (DAGs) are used in **Apache Airflow** to automate the workflow of fetching, transforming, and validating medical data. In this project, DAGs manage dependencies between tasks such as downloading data, cleaning patient records, and generating summary reports.  

The **Airflow-based DAG** ensures that tasks are executed in the correct sequence and **automatically retried** in case of failure. This improves system reliability and reduces manual intervention.  

### 4.2 Dataset Details  

The dataset used is [PMC-Patients Dataset](https://huggingface.co/datasets/zhengyun21/PMC-Patients), which consists of anonymized patient summaries extracted from PubMed Central. The dataset contains key attributes such as:  

| Column | Description |
|--------|------------|
| `patient_uid` | Unique identifier for each patient |
| `PMID` | PubMed Identifier for the source article |
| `title` | Title of the source article |
| `patient` | Summary of patient condition |
| `age` | Age of the patient with time unit |
| `gender` | Gender of the patient (M or F) |
| `relevant_articles` | List of related articles for case references |
| `similar_patients` | Similar patients based on condition |

## 5. Data Processing  

### 5.1 Downloading the Dataset  

The dataset is downloaded either from Hugging Face [PMC-Patients Dataset](https://huggingface.co/datasets/zhengyun21/PMC-Patients) and loaded into [Amazon S3 Data Storage](https://aws.amazon.com/s3/). This step ensures that the most recent version of the medical dataset is available.  

### 5.2 Preprocessing  

Data preprocessing improves consistency and readability for machine learning models. Several transformations are applied:  

- **Text Cleaning**: Non-alphanumeric characters are removed from patient descriptions to reduce noise.  
- **Feature Selection**: Only important columns are retained to focus on relevant data.  
- **Age Conversion**: Age is converted into a numerical format (years) for better analysis.  
- **Handling Missing Values**: Missing gender values are replaced with a neutral category.  
- **Data Formatting**: Dictionary fields like relevant_articles and similar_patients are cleaned for structured retrieval.  

### 5.3 Feature Engineering  

During preprocessing, new columns are created to improve model performance:  

- **Age in Years**: Converts multiple age units (days, weeks, months) into a uniform numerical value.  
- **Binary Gender Encoding**: Gender is mapped to numeric values (1 for male, 0 for female).  
- **Article Relevance Mapping**: Extracts only highly relevant articles for each patient case.  

## 6. Data Validation and Statistics  

### 6.1 Generating Summary Statistics  

Once preprocessing is complete, a statistics report is created. This helps in understanding data distribution and potential anomalies. The report includes:  

- Distribution of patient ages  
- Frequency of common diagnoses  
- Count of male and female patients  
- Missing data percentage per column  

## 7. DAG Optimization  

[Gantt Charts](https://en.wikipedia.org/wiki/Gantt_chart) are used to visualize task dependencies in the DAG execution. By analyzing bottlenecks, optimizations were implemented to reduce computation time. The dataset preprocessing step was improved by restricting processing to only necessary columns, reducing execution time by 30 percent.  

Below is an **Airflow DAG visualization** of the data pipeline execution.  

![Airflow DAG Execution](/images/Projects/mlops/24_fall/group_10/16.webp)  

Each task in the DAG represents a stage in the data pipeline, ensuring that failures are tracked and resolved automatically.  

## 8. Unit Testing  

Unit tests ensure that each stage of the pipeline is functioning correctly. The following tests are included:  

- **Data Download Test**: Verifies that the dataset is downloaded correctly.  
- **Preprocessing Test**: Ensures that transformations such as text cleaning and feature engineering are applied correctly.  
- **Statistics Report Test**: Checks that the generated statistical summary is complete and contains relevant information.  

## 9. Anomaly Detection  

Anomalies in this pipeline refer to unexpected values in patient records. These include:  

- Age values exceeding 120 years  
- Gender values outside of M or F  
- Missing patient summary descriptions  
- Incorrectly formatted article reference links  

Automated alerts are triggered when anomalies are detected.  

## 10. Alerts and Monitoring  

Alerts are sent for the following issues:  

- **Download Failure**: If the dataset cannot be retrieved  
- **Data Corruption**: If missing values exceed a threshold  
- **Processing Errors**: If transformations fail or output files are incomplete  

## 11. Conclusion  

The data pipeline ensures that medical data is cleaned, structured, and validated before being used for AI-based medical analysis. The **Airflow DAG automates data processing**, improving efficiency and reducing errors. This enables reliable AI-driven insights for medical decision-making.  


### References: 
- [Source Code for Data Pipeline](https://github.com/deepaku23/MedifyAI/tree/main/backend/data_pipeline)