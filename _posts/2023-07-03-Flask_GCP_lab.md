---
title: Flask_GCP_lab
subtitle: 
date: 2024-02-18 00:00:00
description: 
featured_image: '/images/demo/demo-square.webp'
author: 
course: MLOps
categories: api
overview: "Flask - API"
---


## Getting Started

1. **Fork this Repository**: Click the "Fork" button at the top right of this [**repository**](https://github.com/raminmohammadi/MLOps/) to create your own copy.
3. **Clone Your Repository**:
   ```bash
   git clone https://github.com/your-username/your-forked-repo.git
   cd your-forked-repo

   ```
4. GitHub account
5. Basic knowledge of Python and machine learning
6. Git command-line tool (optional)


This repository contains code to develop a Flask API and deploy on GCP. For details around GCP deployment refer to the traning [video](https://www.youtube.com/watch?v=O0X6NoQyEf0&list=PLcS4TrUUc53LeKBIyXAaERFKBJ3dvc9GZ&index=8).

## How to start:

Install the [google cloud CLI](https://cloud.google.com/sdk/docs/install) based on your operating system and make sure the gcloud command works 

```
gcloud init
```
Make sure you have authenticated with the correct email Id and selected the correct project id and region
```
gcloud auth login
```

Also make sure you have enabled the folllowing API's
1. Artifact Registry
2. Cloud build

To dockerize the application run

```
gcloud builds submit --tag gcr.io/[YOUR_PROJ_ID]/iris-app
```  

```
gcloud run deploy iris-app --image gcr.io/[YOUR_PROJ_ID]/iris-app --platform managed --port 8501 --allow-unauthenticated   
```

Once the application is deployed you can update the deployed URL in your frontend source code.

