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

## 1. Deployment on Google Cloud Platform

The modularized scripts after testing need to be deployed on Google Cloud for automatic training as well as online prediction.

### 1.1 Initial Google Cloud Configuration

#### 1.1.1 Setup for Google Cloud:

1. Goto IAM & Admin > service accounts and create a service account with the following roles:
    - Storage Admin
    - Vertex AI Admin
    - AI Platform Admin
    - Artifact Registry Administrator
    - Service Account Admin
2. Create a separate bucket, if required, for model training and serving instance by:
    1. Navigate to Google Cloud Console. Ensure you have created a new project or are under the correct project.
    2. Select Cloud Storage > Buckets. Choose an existing bucket and skip steps 3-7, or create a new bucket, as required.
    3. Assign a unique bucket-name. Choose region from the drop down list. **Note:** Separate regions may have different billing rates, so choose accordingly.
    4. Proceed by clicking "Continue" until your new bucket is successfully created.
3. Go to the Google Cloud Console. Navigate to APIs & Services > Library. Search for and enable the **Container Registry API** and the **Vertex AI API**.
4. Install and initialize the Google Cloud CLI on your local device to authenticate and interact with Google Cloud services from the command line.
    ```python
        gcloud auth login
        gcloud config set project [YOUR_PROJECT_ID]
    ```
5. Configure Docker to use the gcloud command-line tool as a credential helper:
    ```python
        gcloud auth configure-docker us-east1-docker.pkg.dev
    ```
6. Run the following command to authorize GCP at command line. **Replace service_account.json with the name of the json file you downloaded.**
    ```python
        gcloud auth activate-service-account --key-file=service_account.json
    ```

#### 1.1.2 Setup for enviroment:

Create a `.env` file in the root of your project directory with the following content. This file should not be
committed to your version control system so add it to your .gitignore file. This file will be used to store the
environment variables used in the project. You can change the values of the variables as per your
requirements.

**Note:** `[YOUR_PROJECT_ID]` should be the name of your GCP project ID, `[FOLDER_NAME]` should be the name of the
folder in which you want to store the docker images in the Artifact Registry.
`[YOUR_SERVICE_ACCOUNT_EMAIL]` should be the email address of the service account you created.
    
```python
    # Google Cloud Storage bucket name
    BUCKET_NAME= [YOUR_BUCKET]

    # Google Cloud Storage bucket directory for storing the data
    BASE_OUTPUT_DIR=gs://[YOUR_BUCKET]

    # Google Cloud AI Platform model directory
    AIP_MODEL_DIR=gs://[YOUR_BUCKET]/model

    # Google Cloud region
    REGION=us-east1

    # Google Cloud project ID
    PROJECT_ID=[YOUR_PROJECT_ID]

    # Container URI for training
    CONTAINER_URI=us-east1-docker.pkg.dev/[YOUR_PROJECT_ID]/[FOLDER_NAME]/trainer:v1

    # Container URI for model serving
    MODEL_SERVING_CONTAINER_IMAGE_URI=us-east1-docker.pkg.dev/YOUR_PROJECT_ID/[FOLDER_NAME]/serve:v1

    # Health check route for the AI Platform model
    AIP_HEALTH_ROUTE=/ping

    # Prediction route for the AI Platform model
    AIP_PREDICT_ROUTE=/predict

    # Service account key file path
    SERVICE_ACCOUNT_EMAIL= [YOUR_SERVICE_ACCOUNT_EMAIL]
```

<hr>

### 1.2 Training Scripts

[Link to folder](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/tree/main/gcpdeploy/src/trainer)

The model is trained using K-Means_Clustering function. It takes 3 inputs and gives 2 outputs. The three inputs are PCA dataframe, transaction dataframe and number of clusters. The outputs are PCA dataframe and transaction dataframe with 'cluster' columns. 

We have made a separate folder that contains the main and supporting scripts for training with functionalities are as given below:
- `ClusterBasedRecommender.py` : It contains K-Means_Clustering algorithm, removing_outliers and hyper parameter tuning.
- `train.py`: Creates the model and saves it on Google Cloud after using the train data from Google Cloud.
- `Dockerfile` : Used to host the training module.

#### 1.2.1 Setup for Training:

The Dockerfile for creating image for Training needs to be updated:

![Image: Modifications for Train.py](/images/Projects/mlops/23_fall/group_7/trainer_dockerfile.webp)

<hr>

### 1.3 Serving Scripts

[Link to folder](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/tree/main/gcpdeploy/src/serve)

The main and supporting scripts for Serving with functionalities are as given below:
- `predict.py`: The flask app to predict clusters based on input json data.
- `Dockerfile` : Used to host the serving module.

#### 1.3.1 Setup for Serving:

The Dockerfile for creating image for Serving needs to be updated:

![Image: Modifications for Serve.py](/images/Projects/mlops/23_fall/group_7/server_dockerfile.webp)

<hr>

**_Image: Model Training and Serving_**

![Model Training and Serving Pipeline](/images/Projects/mlops/23_fall/group_7/Model_Pipeline.webp)

<hr>

### 1.4 Script for Automating actions on GCP

- `build.py` : Will create a training job using the images from the above trainer and serve in Vertex AI. At the end of the job it will automatically deploy the latest trained model to the endpoint for serving and making predictions.
[Link](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/blob/main/gcpdeploy/src/build.py)

#### 1.4.1 Setup for Building and Pushing Train Image:

Navigate to your src folder and run the following commands at **Commandline**:

```
    docker build -f trainer/Dockerfile -t us-east1-
    docker.pkg.dev/[YOUR_PROJECT_ID]/[FOLDER_NAME]/trainer:v1 .
    docker push us-east1-docker.pkg.dev/[YOUR_PROJECT_ID]/[FOLDER_NAME]/trainer:v1
```

#### 1.4.2 Setup for Building and Pushing Serve Image:

Navigate to your src folder and run the following commands at **Commandline**:

```
    docker build -f serve/Dockerfile -t us-east1-
    docker.pkg.dev/[YOUR_PROJECT_ID]/[FOLDER_NAME]/serve:v1 .
    docker push us-east1-docker.pkg.dev/[YOUR_PROJECT_ID]/[FOLDER_NAME]/serve:v1
```

<hr>

### 1.5 Creating a separate script for online prediction
Once the model is deployed to an endpoint, the inference.py script generates predictions from the model. The predict_custom_trained_model function serves as a REST API endpoint, to obtain predictions by sending the insta    nce data. This function constructs a prediction request tailored to the model's expected input schema and transmits it to the deployed model on Vertex AI for it to create a prediction.

- `inference.py`: It will send a json input to the model to predict the results. [Link](https://github.com/Thomas-George-T/Ecommerce-Data-MLOps/blob/main/gcpdeploy/src/inference.py)

#### 1.5.1 Setup of Flask API for incoming requests 

1. Check if the the Configuration parameters are as per your project setup on Google Cloud Platform.
2. This file should also contain commands/mechanisms to check the endpoint health, autoscaling for multiple instance predictions, etc.
<hr>

**_Image: Online Inference for Direct Endpoint Requests_**

![Endpoint Deployment Pipeline](/images/Projects/mlops/23_fall/group_7/Deployment-Pipeline.webp)

<hr>

## 2. Developing BigQuery Table for Data Insights

We use BigQuery tables for infering the prediction data characteristics with respect to training-data characteristics like min-max values. Moreover, we also use these tables for monitoring the response latency during prediction at serving endpoint.

<hr>

**_Image: Big Query Table Snippet_**

![Big Query Previous Predictions Preview](/images/Projects/mlops/23_fall/group_7/BigQuery.webp)

<hr>

#### 2.1 Setup for BigQuery Table:

1. Go to the BigQuery Console. Ensure that you are working within the correct Google Cloud project. 
2. In the left navigation pane, select the dataset fot the table. Within the dataset, click on the "Create Table" button.
3. Configure the table and fill the options:
    - Table name: Enter a unique name for your table.
    - Schema: Define the schema by specifying the column names, data types, and mode (nullable or required) for each column.
    - Table Type: Choose the appropriate table type, such as "Native table" or "External table."
    - Source Data: If you are creating an external table, provide the source data details (e.g., Cloud Storage URI).
4. You may additionally configure Advanced Options(Clustering, Table Expiration, etc.), if needed.
5. Review and create the Table.

## 3. Data Versioning using dvc and Google Cloud Storage

**_Image: DVC Working_**

![DVC Working](/images/Projects/mlops/23_fall/group_7/dvc-working.webp)

<hr>

#### 3.1 Setup for dvc:

1. Ensure you have DVC with Google Cloud support installed on your system by using the following command:
    ```python
        pip install dvc[gs]
    ```
2. Create a new bucket by following instructions in point 2 in Section-A of Deployment. Then, replace <mybucket> in command below with your bucket-name.
    ```python
        dvc remote add -d myremote gs://<mybucket>
    ```
        **OR**

        To follow a folder structure, add the folder location as default to your remote bucket.
    ```python
        dvc remote add -d myremote gs://<yourbucket>/<folderpath>
    ```
3. Download the json token for your bucket and save it at a secure location.
4. Don't forget to modify your credentials.
    ```python
        dvc remote modify --<remote-name> credentialpath <YOUR JSON TOKEN PATH>
    ```
5. Goto the parent directory of your local repository, then initialize dvc.
    ```python
    dvc init
    ```
6. Verify that a .dvc folder is created in the parent directory. Your .dvc file config metadata will look something like this    
    ```python
    [core]
    remote = <remote-name>

    ['remote "remote-name"']
    url = gs://<remote-name>
    ```
7. DVC commands are similar to git commands. To add the files under dvc tracking, use command:
    ```python
    dvc add <folderpath>/<filepath>
    ```
<hr>  

**_Image: DVC demo of local files under our project_**

![dvc snippet](/images/Projects/mlops/23_fall/group_7/dvc.webp)

<hr>