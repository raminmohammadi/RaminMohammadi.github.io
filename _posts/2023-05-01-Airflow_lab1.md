---
title: Airflow Lab-1
subtitle: 
date: 2024-02-19 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: 
course: MLOps
categories: airflow
overview: "Docker, Airflow-DAGs"
---

This lab revolves around two key modules:
1. **Docker:** A platform for developing, shipping, and running applications in containers.
2. **Airflow:** A platform to programmatically author, schedule, and monitor workflows.

In this lab, we create a machine-learning workflow using `Airflow` which automates a task of data clustering using K-Means clustering and determining optimal number of clusters with the elbow method.

The workflow involves the following steps:
1. Load data from a CSV file.
2. Perform data preprocessing.
3. Build and save a K-Means clustering model.
4. Load the saved model and determine the optimal number of clusters based on the elbow method.

#### Prerequisites

1. [Github Lab-1]({% link _posts/2023-02-01-GitHub_lab1.md %})
2. Docker Desktop Installed
    - [Windows Installation](https://docs.docker.com/desktop/install/windows-install/)
    - [Mac Installation](https://docs.docker.com/desktop/install/mac-install/)
    - [Linux Installation](https://docs.docker.com/desktop/install/linux-install/)
3. Basics of Docker - containers and images.

## Setting up the lab

**Note:** If you'd like to save your work files to GitHub, setup your working directory similar to [Github Lab-1]({% link _posts/2023-02-01-GitHub_lab1.md %}) and add your virtual environment and other necessary files to `.gitignore`. If you just want to run the lab locally, follow the below steps.

1. Open the local **mlops_labs** directory using Visual Studio Code(VSC) and open a new terminal(**use cmd for windows**) inside VSC.
2. Create a new working directory for this lab(e.g. **airflow_lab1**).
3. Move into the working directory using the command **cd airflow_lab1** in your terminal.
4. Get the **requirements.txt** file from [here](https://github.com/raminmohammadi/MLOps/blob/main/Labs/Airflow_Labs/Lab_1/requirements.txt).
5. Create a virtual environment(e.g. **airflow_lab1_env**).
6. Activate the environment and install the required packages using **pip install -r requirements.txt**.

## Getting the necessary files

Get the required files for this lab from the MLOps repo.

> [GitHub link](https://github.com/raminmohammadi/MLOps/tree/main/Labs/Airflow_Labs/Lab_1)

**Project Structure:**

```
    mlops_labs/
    └── airflow_lab1/
        ├── requirements.txt
        ├── airflow_lab1_env/
        └── dags/
            ├── data/
            │   ├── file.csv  
            │   └── test.csv
            ├── model/        
            ├── src/
            │   ├── __init__.py
            │   └── lab2.py
            └── airflow.py
```

### Airflow 

We use Airflow to author workflows as directed acyclic graphs (DAGs) of tasks. The Airflow scheduler executes your tasks on an array of workers while following the specified dependencies.

**References:**
- [Product](https://airflow.apache.org/)
- [Documentation](https://airflow.apache.org/docs/)
- [Github](https://github.com/apache/airflow)

**Prerequisites:** 

- Local
    - Docker Desktop Running
- Cloud
    -   Linux VM
    -   SSH Connection
    -   Installed Docker Engine - [Install using the convenience script](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script)

You should allocate at least 4GB memory for the Docker Engine (ideally 8GB).


## Running an Apache Airflow DAG Pipeline in Docker


This guide provides detailed steps to set up and run an Apache Airflow Directed Acyclic Graph (DAG) pipeline within a Docker container using Docker Compose. The pipeline is named **your_python_dag**".

1. Make sure `Docker Desktop` is up and running.
2. In this lab, we will run `Airflow` inside `Docker`. Hence, we didn't list it in `requirements.txt` file and install using `pip`. Refer [Running Airflow in Docker](https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html#running-airflow-in-docker).
3. You can check if you have enough memory by running this command (optional)
    ```bash
    docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'
    ```
4. Fetch [docker-compose.yaml](https://airflow.apache.org/docs/apache-airflow/2.5.1/docker-compose.yaml).
    ```bash
    # mac and linux users 
    curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.8.1/docker-compose.yaml'

    # windows users 
    curl -o docker-compose.yaml https://airflow.apache.org/docs/apache-airflow/2.8.1/docker-compose.yaml
    ```
5. Setting the right Airflow user. This will create a `.env` file.
    ```bash
    # mac and linux users
    mkdir -p ./logs ./plugins ./working_data
    
    # windows users
    mkdir logs plugins working_data

    echo -e "AIRFLOW_UID=$(id -u)" > .env
    ```
    - If you are on windows platform, replace the content of `.env` file with the following.
    ```bash
    AIRFLOW_UID=50000
    ```
6. Update the following in `docker-compose.yml`.
    ```bash
    # Donot load examples
    AIRFLOW__CORE__LOAD_EXAMPLES: 'false'

    # Additional python packages
    _PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:- pandas scikit-learn kneed}

    # Output dir
    - ${AIRFLOW_PROJ_DIR:-.}/working_data:/opt/airflow/working_data

    # Change default admin credentials
    _AIRFLOW_WWW_USER_USERNAME: ${_AIRFLOW_WWW_USER_USERNAME:-airflow2}
    _AIRFLOW_WWW_USER_PASSWORD: ${_AIRFLOW_WWW_USER_PASSWORD:-airflow2}
    ```
7. Initialize the database. This will take a couple of minutes.
    ```bash
    docker compose up airflow-init
    ```
8. Run Airflow.
    ```bash
    docker compose up
    ```
    Wait until terminal outputs

    ```bash
    airflow-webserver-1  | 127.0.0.1 - - [19/Feb/2024:17:16:53 +0000] "GET /health HTTP/1.1" 200 318 "-" "curl/7.88.1"
    ```
9. Enable port forwarding. Windows users click "allow" in the pop-up window.
10. Visit `localhost:8080` and login with credentials set on step `2.d`.
11. You will see your dag(**your_python_dag**) as shown in the below image. For this lab, you are already given a dag script - `dags/airflow.py`.
    <img src="/images/Posts/MLOps/airflow_lab1/image_1.webp" width="100%">
    You can create more dags with similar scripts.
    - BashOperator
    - PythonOperator
    - Task Dependencies
    - Params
    - Crontab schedules

    You can have n number of scripts inside the `dags` directory.
12. To manually trigger the DAG, click on the "Trigger DAG" button or enable the DAG by toggling the switch to the "On" position.
    - Monitor the progress of the DAG in the Airflow web interface. You can view logs, task status, and task execution details in airflow UI and also in `logs` directory.
    - Once the DAG completes its execution, check any output or artifacts produced by your functions and tasks.

13. Click on your dag(**your_python_dag**) -> **Graph** tab -> click on the last rectangle box in the graph(**load_model_task**) -> **Logs** tab. You will find the result of the workflow i.e., **optimal number of clusters** as shown in the below image.
    <img src="/images/Posts/MLOps/airflow_lab1/image_2.webp" width="100%">
13. Explore UI and add user `Security > List Users`. (optional)
14. To stop Airflow, we have to stop the docker containers. For this, we have to open a new terminal(cmd for windows), activate the virtual enviroment and run the following command.
    ```bash
    docker compose down
    ```

**Final Project Structure:**

```
    mlops_labs/
    └── airflow_lab1/
        ├── airflow_lab1_env/
        ├── config/
        ├── dags/
        │   ├── airflow.py # Your DAG script
        │   ├── data/ # Directory for data/
        │   │   ├── file.csv
        │   │   └── test.csv
        │   ├── src/
        │   │   ├── __init__.py
        │   │   └── lab2.py # Data processing and modeling functions
        │   └── model/
        │       └── model2.sav
        ├── logs/
        ├── plugins/
        ├── working_data/
        ├── .env
        ├── docker-compose.yaml
        └── requirements.txt
```

**Note:** If your working in a git repo, make sure to add `__pycache__` to `.gitignore`.

### Airflow DAG Script

This part of the lab provides a detailed explanation of the **dags/airflow.py** python script that defines an Airflow Directed Acyclic Graph (DAG) for a data processing and modeling workflow.

#### Script Overview

The script defines an Airflow DAG named `your_python_dag` that consists of several tasks. Each task represents a specific operation in a data processing and modeling workflow. The script imports necessary libraries, sets default arguments for the DAG, creates PythonOperators for each task, defines task dependencies, and provides command-line interaction with the DAG.

#### Importing Libraries

```python
# Import necessary libraries and modules
from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime, timedelta
from src.lab2 import load_data, data_preprocessing, build_save_model, load_model_elbow
from airflow import configuration as conf
```

The script starts by importing the required libraries and modules. Notable imports include the `DAG` and `PythonOperator` classes from the `airflow` package, datetime manipulation functions, and custom functions from the `src.lab2` module.

#### Enable pickle support for XCom, allowing data to be passed between tasks

```python
conf.set('core', 'enable_xcom_pickling', 'True')
```

#### Define default arguments for your DAG

```python
default_args = {
    'owner': 'your_name',
    'start_date': datetime(2023, 9, 17),
    'retries': 0,  # Number of retries in case of task failure
    'retry_delay': timedelta(minutes=5),  # Delay before retries
}
```

Default arguments for the DAG are specified in a dictionary named default_args. These arguments include the DAG owner's name, the start date, the number of retries, and the retry delay in case of task failure.

#### Create a DAG instance named 'your_python_dag' with the defined default arguments

``` python 
dag = DAG(
    'your_python_dag',
    default_args=default_args,
    description='Your Python DAG Description',
    schedule_interval=None,  # Set the schedule interval or use None for manual triggering
    catchup=False,
)
```

Here, the DAG object is created with the name `your_python_dag` and the specified default arguments. The description provides a brief description of the DAG, and `schedule_interval` defines the execution schedule (in this case, it's set to None for manual triggering). `catchup` is set to False to prevent backfilling of missed runs.

#### Task to load data, calls the 'load_data' Python function

``` python 
load_data_task = PythonOperator(
    task_id='load_data_task',
    python_callable=load_data,
    dag=dag,
)
```

#### Task to perform data preprocessing, depends on 'load_data_task'

```python 
data_preprocessing_task = PythonOperator(
    task_id='data_preprocessing_task',
    python_callable=data_preprocessing,
    op_args=[load_data_task.output],
    dag=dag,
)
```

The `data_preprocessing_task` depends on the `load_data_task` and calls the `data_preprocessin`g` function, which is provided with the output of the `load_data_task`.

#### Task to build and save a model, depends on 'data_preprocessing_task'

```python
build_save_model_task = PythonOperator(
    task_id='build_save_model_task',
    python_callable=build_save_model,
    op_args=[data_preprocessing_task.output, "model2.sav"],
    provide_context=True,
    dag=dag,
)
```
The `build_save_model_task` depends on the `data_preprocessing_task` and calls the `build_save_model` function. It also provides additional context information and arguments.

#### Task to load a model using the 'load_model_elbow' function, depends on 'build_save_model_task'

``` python
load_model_task = PythonOperator(
    task_id='load_model_task',
    python_callable=load_model_elbow,
    op_args=["model2.sav", build_save_model_task.output],
    dag=dag,
)
```

The `load_model_task` depends on the `build_save_model_task` and calls the load_model_elbow function with specific arguments.

#### Set task dependencies

```python
load_data_task >> data_preprocessing_task >> build_save_model_task >> load_model_task
```

The task dependencies are defined using the **>>** operator. In this case, the tasks are executed in sequence: **load_data_task** -> **data_preprocessing_task** -> **build_save_model_task** -> **load_model_task**.

#### If this script is run directly, allow command-line interaction with the DAG

```python
if __name__ == "__main__":
    dag.cli()
```

- Lastly, the script allows for command-line interaction with the DAG. When the script is run directly, the **dag.cli()** function is called, providing the ability to trigger and manage the DAG from the command line.

#### Usage for your custom dataset

You can modify this script to perform K-Means clustering on your own dataset keeping the high-level functions same as follows:

```python
# Load the data
data = load_data()

# Preprocess the data
preprocessed_data = data_preprocessing(data)

# Build and save the clustering model
sse_values = build_save_model(preprocessed_data, 'clustering_model.pkl')

# Load the saved model and determine the number of clusters
result = load_model_elbow('clustering_model.pkl', sse_values)
print(result)
```

#### Functions

1. **load_data():**
   - **Description:** Loads data from a CSV file, serializes it, and returns the serialized data.
   - **Usage:**
     ```python
     data = load_data()
     ```

2. **data_preprocessing(data)**
   - **Description:** Deserializes data, performs data preprocessing, and returns serialized clustered data.
   - **Usage:**
     ```python
     preprocessed_data = data_preprocessing(data)
     ```

3. **build_save_model(data, filename)**
   - **Description:** Builds a K-Means clustering model, saves it to a file, and returns SSE values.
   - **Usage:**
     ```python
     sse_values = build_save_model(preprocessed_data, 'clustering_model.pkl')
     ```

4. **load_model_elbow(filename, sse)**
   - **Description:** Loads a saved K-Means clustering model and determines the number of clusters using the elbow method.
   - **Usage:**
     ```python
     result = load_model_elbow('clustering_model.pkl', sse_values)
     ```