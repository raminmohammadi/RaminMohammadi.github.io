---
featured_image: '/images/Projects/mlops/23_fall/group_7/thumbnail.webp'
---

### Outline:
1. [Introduction]({% link _projects/mlops/2024-01-01-f23-group-7.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/23_fall/group_7/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/23_fall/group_7/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/23_fall/group_7/modeling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/23_fall/group_7/deployment.md %} ){:target="_blank"}<br>
6. [Monitoring]( {% link _projects_mlops/23_fall/group_7/monitoring.md %} ){:target="_blank"}<br>

## 1. Dataset Information 
This is a transnational data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.The company mainly sells unique all-occasion gifts. Many customers of the company are wholesalers.

## 2. Data Card
- Size: 541909 rows × 8 columns
- Data Types
  
| Variable Name |Role|Type|Description|
|:--------------|:---|:---|:----------|
|InvoiceNo |ID	|Categorical	|a 6-digit integral number uniquely assigned to each transaction. If this code starts with letter 'c', it indicates a cancellation |
|StockCode |ID	|Categorical	|a 5-digit integral number uniquely assigned to each distinct product |
|Description|Feature	|Categorical	|product name |
|Quantity	|Feature	|Integer	|the quantities of each product (item) per transaction |
|InvoiceDate	|Feature	|Date	|the day and time when each transaction was generated |
|UnitPrice	|Feature	|Continuous	|product price per unit |
|CustomerID	|Feature	|Categorical	|a 5-digit integral number uniquely assigned to each customer |
|Country	|Feature	|Categorical	|the name of the country where each customer resides |

## 3. Data Sources 
The data is taken from [UCI repository](https://archive.ics.uci.edu/dataset/352/online+retail)


Our data pipeline is modularized right from data ingestion to preprocessing to make our data ready for modeling. It is made sure that every module functions as expected by following Test Driven Development (TDD). This is achieved through enforcing tests for every module. 

We utilize Apache Airflow for our pipeline. We create a DAG with our modules.

![DAG Image](/images/Projects/mlops/23_fall/group_7/dag.webp "Airflow DAG")
Pictured: Our Airflow DAG

The following is the explanation of our Data pipeline DAG

## 4. Airflow Setup

Apache Airflow, a Python-based platform, requires installation via pip, initializing a database, and editing configuration files; afterward, you start its scheduler and web server to manage Directed Acyclic Graphs (DAGs) via a browser-based UI, where you define tasks and their dependencies for workflow automation. Our Airflow script is attached [here](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/blob/main/gcpdeploy/src/airflow.py).

## 5. Data Pipeline Components

![Model Pipeline](/images/Projects/mlops/23_fall/group_7/Data_Pipeline.webp "Model Pipeline")

The data pipeline in this project consists of several interconnected modules, each performing specific tasks to process the data. We utilize Airflow and Docker to orchestrate and containerize these modules, with each module functioning as a task in the main data pipeline DAG (`datapipeline`).

### 5.1. Downloading Data:
The first stage involves downloading and unzipping the dataset into the `data` directory. This is achieved through the following modules:
- `download_data.py`: Responsible for downloading the dataset from the specified source.
- `unzip_data.py`: Extracts the contents of the downloaded zip file for further processing.

### 5.2. Cleaning Data:
In this phase, the dataset undergoes various cleaning and preprocessing steps to ensure data quality and readiness for analysis. The following modules are involved in this process:
- `data_loader.py`: Loads the data from the Excel file and prepares it for cleaning.
- `missing_values_handler.py`: Identifies and handles missing values in the dataset.
- `duplicates_handler.py`: Detects and removes duplicate records to maintain data integrity.
- `transaction_status_handler.py`: Processes the transaction status data, extracting relevant features.
- `anomaly_code_handler.py`: Identifies and corrects anomalies in product codes to ensure data accuracy.
- `cleaning_description.py`: Remove rows where the description contains service related information.
- `removing_zero_unitprice.py`: Removing rows where unit price is zero.
- `outlier_treatment.py`: Identifies and removes outliers.

Each module in the pipeline reads data from an input pickle path, processes it, and outputs the results to an output pickle path. The seamless integration of these modules within Airflow ensures a streamlined and efficient data processing workflow.

### 5.3. Feature Engineering:
In this step, we perform feature engineering to analyze and modify the features to further improve the training and improve the results and evaluation metrics. The following modules are created for feature engineering:
- `rfm.py`: This module analyzes Recency, Frequency and Monetary methods to know about the value of customers and dividing the base.
- `unique_products.py`: This module groups the values based on unique values of ‘CustomerID’ and orders.
- `customers_behavior.py`: The module shows how the behavioral patterns of customers affect the business based on weekly frequency.
- `geographic_features.py`: This module defines the distribution of the customers' data with respect to regions.
- `cancellation_details.py`: This module shows how cancelling of orders affects the business and the data. It also shows the frequency of cancellation and cancellation			     rate.
- `seasonality.py`: This module analyzes the seasonal trends and how they affect customers and business.

The inputs for these modules are pickle files which are taken as dataframes and outputs are paths to the pickle files which are stores the values from the dataframes which are created after each task.
