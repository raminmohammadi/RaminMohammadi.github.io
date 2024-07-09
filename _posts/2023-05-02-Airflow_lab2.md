---
title: Airflow Lab-2
subtitle: 
date: 2024-02-19 00:00:00
description:
featured_image: '/images/demo/demo-square.webp'
author: Sai Akhilesh Ande
course: MLOps
categories: airflow
overview: "Airflow-DAGs, E-mail notifications, FastAPI"
---

- Lab Credits: [Prof. Ramin Mohammadi]( {% link _abouts/2022-01-03-Ramin.md %} )
- Blog Credits: [Sai Akhilesh Ande]( {% link _tas/Sai Akhilesh Ande.md %})

--- 

#### **Note:**

1. Airflow lab-1 used Docker with which we were able to run on all Operating Systems. But, this lab requires installation of airflow.
2. Hence, this lab requires Linux based operating systems (MacOS, Ubuntu, etc.). To install on Windows OS, install it via WSL2 or install Ubuntu through virtual box/vmware.

---

In this lab, we create a machine-learning workflow using `Airflow` which trains a logistic regression model on advertising data, sends email notifications and monitors the status using Flask API.  

The workflow involves the following steps:
1. Installing Airflow (`pip install`)
2. Configuring `airflow.cfg` for emails.
3. Integrating email notifications.
4. Monitoring workflow using FlaskAPI.

#### Prerequisites

1. [Github Lab-1]({% link _posts/2023-02-01-GitHub_lab1.md %})
2. Basic understanding of Airflow concepts ([Airflow Lab-1]({% link _posts/2023-05-01-Airflow_lab1.md %}))

## Setting up the lab

> [GitHub link](https://github.com/raminmohammadi/MLOps/tree/main/Labs/Airflow_Labs/Lab_2)

**Note:** If you'd like to save your work files to GitHub, setup your working directory similar to [Github Lab-1]({% link _posts/2023-02-01-GitHub_lab1.md %}) and add necessary files to `.gitignore`. If you just want to run the lab locally, follow the below steps.

1. Open the local **mlops_labs** directory using Visual Studio Code(VSC) and open a new terminal inside VSC.
2. Create a new working directory for this lab(e.g. **airflow_lab2**).
3. Move into the working directory using the command **cd airflow_lab2** in your terminal.
4. Copy the **dags** folder and **requirements.txt** to your working directory.
5. Create a virtual environment(e.g. **airflow_lab2_env**).
6. Activate the environment and install the required packages using `pip install -r requirements.txt`.

**Project Structure:**

```
    mlops_labs
    └── airflow_lab2
        ├── airflow_lab2_env
        ├── dags
        │   ├── data
        │   │   └── advertising.csv
        │   ├── model
        │   ├── src
        │   │   └── model_development.py
        │   ├── templates
        │   │   ├── failure.html
        │   │   └── success.html
        │   ├── Flask_API.py
        │   └── main.py
        └── requirements.txt
```

## Running Apache Airflow

1. Setting up airflow path - Run this command in the terminal inside VSC.
    ```bash
    export AIRFLOW_HOME=~airflow
    ```
    - This will create a folder named **airflow** in your **home directory**.
2. Setting up the database - Apache Airflow requires a database. For our labs, we can stick to the default SQLite option.
    ```bash
    airflow db migrate
    ```
    - This command creates the database schema if it does not exist or migrate to the latest version if it does.
    - You will notice that a folder **logs** and files **airflow.cfg**, **airflow.db** created in the **airflow** directory. 
3. Creating a user
    ```bash
    airflow users create \
        --username akhil \
        --firstname "Sai Akhilesh" \ 
        --lastname Ande \
        --role Admin \
        --email <email@northeastern.edu>
    ```
    - If you want to give multiple words for an argument, use `" "`.
4. Airflow has multiple components - **webserver** and **scheduler**.
   - **scheduler:**  Handles both triggering scheduled workflows, and submitting Tasks to the executor to run. The executor, is a configuration property of the scheduler, not a separate component and runs within the scheduler process.  
Configuring Airflow. There are several executors available out of the box, and you can also write your own.
   - **webserver:** presents a handy user interface to inspect, trigger and debug the behaviour of DAGs and tasks.
   - So, we have to start both of them in two seperate terminals.
    ```bash
     # you can change port if you have something else running in this port.
     airflow webserver --port 8080  
    
     # run in a seperate terminal.
     airflow scheduler 
    ``` 
5. Configuring Airflow
    - All configurations of airflow are stored in the `airflow/airflow.cfg` file.
    - Any configuration changes should be made in this file.
    ```bash
    # this will not load the default DAG examples that ship with Airflow.
    load_examples = False 
    ```
6. Now, stop both servers(Ctrl + C), go through the next sections to begin working on this lab.
7. Once, the following changes are made, restart both servers again to run the DAGs.

### Sign in with app passwords

- Follow the instruction provided here: [link](https://support.google.com/accounts/answer/185833) and get your **smtp password**.

### Adding SMTP Information to airflow.cfg

To configure Airflow to send emails, you need to add SMTP information to the `airflow.cfg` file. Follow these steps:

1. Locate the `airflow.cfg` file in your **airflow** directory.
2. Open the file in VSC or a text editor.
3. Search for the `[smtp]` section in the configuration file.
4. Update the following parameters with your SMTP server information:
   - `smtp_host`: Hostname of the SMTP server.
   - `smtp_starttls`: Set it to `True` if your SMTP server uses TLS.
   - `smtp_ssl`: Set it to `True` if your SMTP server uses SSL.
   - `smtp_user`: Your SMTP username.
   - `smtp_password`: Your SMTP password.
   - `smtp_port`: Port number of the SMTP server (e.g., 587 for TLS, 465 for SSL).
5. Save the changes to the `airflow.cfg` file.

for our lab assuming you have a gmail account you can use the following setting:
   - smtp_host = smtp.gmail.com
   - smtp_starttls = True
   - smtp_ssl = False
   - smtp_user = YOUREMAIL@gmail.com
   - smtp_password = Enter your password generated above
   - smtp_port = 587
   - smtp_mail_from = YOUREMAIL@gmail.com
   - smtp_timeout = 30
   - smtp_retry_limit = 5

After updating the SMTP information, Airflow will use the configured SMTP server to send email notifications.

## DAG Structure

### `Airflow_Lab2`
This DAG orchestrates a machine learning pipeline and notification system. Let's break down each function within this DAG:

1. **`notify_success(context)` and `notify_failure(context)` Functions:**
   - These functions define email notifications for task success and failure, respectively. They utilize the `EmailOperator` to send emails with predefined content and subject to a specified recipient (in this case, `rey.mhmmd@gmail.com`).

2. **`default_args` Dictionary:**
   - This dictionary defines default arguments for the DAG, including the start date and the number of retries in case of task failure.

3. **`dag` Definition:**
   - This section creates the main DAG instance (`Airflow_Lab2`) with various parameters such as description, schedule interval, catchup behavior, and tags.
   
4. **`owner_task` BashOperator:**
   - This task echoes `1` and is assigned to an owner (`Ramin Mohammadi`). It represents a simple demonstration task with a linked owner.

5. **`send_email` EmailOperator:**
   - This task sends a notification email upon DAG completion. It utilizes the `notify_success` and `notify_failure` functions as callbacks for success and failure, respectively.

6. **PythonOperator Tasks:**
   - These tasks execute Python functions (`load_data`, `data_preprocessing`, `separate_data_outputs`, `build_model`, `load_model`) representing different stages of a machine learning pipeline. They perform data loading, preprocessing, model building, and model loading tasks.

7. **`TriggerDagRunOperator` Task:**
   - This task triggers the `Airflow_Lab2_Flask` DAG upon successful completion of the main DAG. It ensures that the Flask API is launched after the machine learning pipeline completes successfully.

### `Airflow_Lab2_Flask`
This DAG manages the Flask API's lifecycle and consists of the following function:

1. **`check_dag_status()` Function:**
   - This function queries the status of the last DAG run (`Airflow_Lab2`). It returns `True` if the DAG run was successful, and `False` otherwise.

2. **`handle_api_request()` Function:**
   - This function handles API requests and redirects users to `/success` or `/failure` routes based on the status of the last DAG run.

3. **Flask Routes and HTML Templates:**
   - The Flask routes (`/api`, `/success`, `/failure`) define endpoints for accessing the API and displaying success or failure pages. These routes render HTML templates (`success.html`, `failure.html`) with appropriate messages.

4. **`start_flask_app()` Function:**
   - This function starts the Flask server, enabling users to access the API endpoints.

5. **`start_flask_API` PythonOperator:**
   - This task executes the `start_flask_app()` function to initiate the Flask server. It represents the starting point for the Flask API's lifecycle.

## Conclusion
In this project, we've constructed a robust workflow using Apache Airflow to orchestrate a machine learning pipeline and manage a Flask API for monitoring purposes. The Airflow_Lab2 DAG coordinates various tasks, including data loading, preprocessing, model building, and email notification upon completion. By leveraging PythonOperators and BashOperator, we've encapsulated each step of the machine learning process, allowing for easy scalability and maintenance.

Additionally, the integration of email notifications enhances the workflow's visibility, providing stakeholders with timely updates on task success or failure. This ensures proactive monitoring and quick response to any issues that may arise during pipeline execution.

Furthermore, the Airflow_Lab2_Flask DAG facilitates the management of a Flask API, enabling users to access endpoints for checking the status of the machine learning pipeline. By querying the last DAG run status, the API delivers real-time feedback, empowering users to make informed decisions based on the pipeline's performance.

Overall, this project demonstrates the power of Apache Airflow in orchestrating complex workflows and integrating external systems seamlessly. By following the provided instructions and understanding the workflow's structure, users can leverage Airflow to streamline their machine learning pipelines and enhance operational efficiency.