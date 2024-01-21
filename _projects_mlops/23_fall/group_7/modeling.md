---
---

### Outline:
1. [Introduction]({% link _projects/2024-01-01-f23-group-7.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/23_fall/group_7/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/23_fall/group_7/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/23_fall/group_7/modeling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/23_fall/group_7/deployment.md %} ){:target="_blank"}<br>
6. [Monitoring]( {% link _projects_mlops/23_fall/group_7/monitoring.md %} ){:target="_blank"}<br>

## 1. Modularizing Feature Engineering Scripts in Airflow
We broke down our pipeline logic into individual tasks using Airflow operators such a Python operator. Operators represent units of work within a complete workflow, and Python Operator allowed us to run modularized python scripts.
[Link to our main Airflow DAG script](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/blob/main/dags/src/airflow.py)

We organized our workflow logic by defining DAGs. A DAG is a collection of tasks with defined dependencies. As each DAG is a smaller, logically organized unit,the individual script becomes independent of unnescessary variables; thus reducing the memory requirements and, in turn, latency. Additionally at the time of version update, this allows to modify a single module rather than the whole script. A peculiar advantage was to use the jinja templates to directly call the output of another operator as the input for current operator. This helps overcome the need to store outputs of each script individually. Furthermore, DAGs for task parallelization and reducing the overall task completion times due to long task chains in serialization.
[Link to our dag component scripts](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/tree/main/dags/src)

<hr>

**_Image: DAGs run preview_**

![dags preview](/images/Projects/mlops/23_fall/group_7/dags.webp)

<hr>

#### 1.1 Setup for Docker

1. Install the Docker desktop app.
2. Create account on Docker for ease of uploading modified images as per your application.
3. Log in to Docker through commandline
    ```
        docker login --username [username]
    ```
    Also, fill in your password in the prompt.
4. Rename image manually or use:
    ```
        docker tag my-image username/my-repo
    ```
5. To upload images:
    ```
        docker push username/my-repo
    ```

#### 1.2 Initial Setup for AirFlow:

1. Start the docker desktop app. You may want to run it "As Administrator" optionally for it to have root access.
2. You may use wsl to run linux commands on windows by following this [wsl Official Link](https://learn.microsoft.com/en-us/windows/wsl/install) guide for installation and usage.
3. You can check if you have enough memory by running this command on command line:
    ```
        docker run --rm "debian:bullseye-slim" bash -c 'numfmt --to iec $(echo $(($(getconf _PHYS_PAGES) * $(getconf PAGE_SIZE))))'
    ```
4. Fetch docker-compose.yaml on Linux
    ```
        curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.5.1/docker-compose.yaml'
    ```
5. Setting the right Airflow user
    ```
        mkdir -p ./dags ./logs ./plugins ./working_data
        echo -e "AIRFLOW_UID=$(id -u)" > .env
    ```
6. Create a docker-compose.yaml file in the project root directory. This file defines the services and configurations for running Airflow in a Docker container. Update the following in docker-compose.yml
    ```    
        # Donot load examples
        AIRFLOW__CORE__LOAD_EXAMPLES: 'false'
        
        # Additional python package
        _PIP_ADDITIONAL_REQUIREMENTS: ${_PIP_ADDITIONAL_REQUIREMENTS:- pandas }
        
        # Output dir
        - ${AIRFLOW_PROJ_DIR:-.}/working_data:/opt/airflow/working_data
        
        # Change default admin credentials
        _AIRFLOW_WWW_USER_USERNAME: ${_AIRFLOW_WWW_USER_USERNAME:-airflow2}
        _AIRFLOW_WWW_USER_PASSWORD: ${_AIRFLOW_WWW_USER_PASSWORD:-airflow2}
    ```
7. In case of non-Linux os, you should manually create an .env file in the same folder as docker-compose.yaml to get rid of unnecessary warnings. It should contain:
    ```
        AIRFLOW_UID=50000
    ```
8. Initialize the database.
    ```
        docker compose up airflow-init
    ```

**Important Note:**
    
While we have defined "pip additional requirements" in the docker file, please avoid doing this for deployment as it ends up increasing the "compose up" time for Airflow. 
- Instead, always modify your base-image by using interactive command:
```
        docker run -it [image-name] /bin/bash
```
- The commands will be run on linux terminal. You may require root access. Update the container image by downloading the additional requirements.
- Upload the modified image to your docker repository. 
- Finally, update your docker yaml file to call the modified image as seen below:
        ![Docker yaml file update](/images/Projects/mlops/23_fall/group_7/docker_yaml_imageupdate.webp)

#### 1.3 General Runs of Airflow insider Docker Containers

1. Run the Docker Desktop app.
2. At commandline, run the command:
    ```
        docker compose up
    ```

    Wait until terminal outputs

    ```
        app-airflow-webserver-1 | 127.0.0.1 - - [17/Feb/2023:09:34:29 +0000] "GET /health HTTP/1.1" 200 141 "-" "curl/7.74.0"
    ```
3. Visit localhost:8080 on your browser. Login with credentials set on step 1.2.6
4. Explore UI and add user Security > List Users
5. Create a python script under dags directory. You can have n number of scripts inside dags directory.
6. To stop docker containers, use
    ```
        docker compose down
    ```

#### 1.3 Operating through UI inside Airflow

1. In the Airflow web interface, navigate to the "DAGs" page. You should see the "your_python_dag" listed.
2. You may change your timezone trhough a drop-down list on RHS top corner.
3. To manually trigger the DAG, click on the "Trigger DAG" button or enable the DAG by toggling the switch to the "On" position.
4. Monitor the progress of the DAG in the Airflow web interface. You can view logs, task status, and task execution details.
5. Once the DAG completes its execution, check any output or artifacts produced by your functions and tasks.

## 2. Using MLFlow to visualize the most optmized model

MLFlow may be used to efficiently compare and log the models during hyperparameter tuning. For our case, the output indices such as Silhouette score, Davies-Bouldin Index and Calinski-Harabasz Index were analyzed while changing values for number of clusters, initialization types, number of initializations and max iterations. Other parameters may be tweaked as per your model requirements.

<hr>

**_Image: Parallel Plot for KMeans for our project_**

![Parallel Plot for KMeans](/images/Projects/mlops/23_fall/group_7/KMeans_Parallelplot.webp)

<hr>

#### 2.1 Setup for MLFlow:

1. Set your tracking uri for MLFlow. To open MLFlow in a browser, run the following command on Commandline.
    ```python
        mlflow.set_tracking_uri("http://127.0.0.1:5001")
    ```
2. Setting the base level for logging; only warnings and above (error,critical) shall be logged.
    ```python
        logging.basicConfig(level=logging.WARN)
    ```
3. Set up the logger.
    ```python
        logger = logging.getLogger(__name__)
    ```
4. Additionally, you may or may not choose to ignore warnings.
    ```python
        warnings.filterwarnings("ignore")
    ```
5. Goto a new tab in your browser and open set uri "http://127.0.0.1:5001".

<hr>

**_Image: MLFlow Dashboard for our project_**

![MLFlow Dashboard for our case](/images/Projects/mlops/23_fall/group_7/MLFlow_dashboard.webp)

<hr>