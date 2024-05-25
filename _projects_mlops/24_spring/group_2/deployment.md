---
featured_image: '/images/Projects/mlops/24_spring/group_2/thumbnail.webp'
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

## GitHub Workflows Overview

This table provides a detailed overview of each workflow file in the `.github/workflows` directory, elaborating on the triggers and main functions of each workflow.

| **Workflow File**                                                                 | **Trigger Events**                      | **Description**                                                                                                                                                 |
|-----------------------------------------------------------------------------------|-----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `deploy-cicd.yml`                            | `workflow_dispatch`                     | Initializes and sets up CI/CD configurations for the project, including environment setups and automatic pull request creation for changes.                      |
| `lint-cicd-workflow-files.yml`   | `pull_request`, `workflow_dispatch`     | Performs linting on GitHub Actions workflow files to ensure syntax correctness and prevent common configuration errors.                                         |
| `LLMOps-bundle-ci.yml`       | `workflow_dispatch`, `pull_request`     | Validates MLOps bundle configurations ensuring all integration settings conform to required standards before merging into the main branch.                      |
| `LLMOps-run-tests.yml`      | `pull_request` (on specific paths), `workflow_dispatch` | Conducts both unit tests and integration tests to validate code integrity and integration readiness, respectively, ensuring the codebase is reliable and functional. |
| `LLMOps-bundle-cd-staging.yml` | `push` (to `main`), `workflow_dispatch` | Manages the deployment of project bundles to the staging environment, including validations and configurations to ensure deployment readiness.                   |
| `LLMOps-bundle-cd-prod.yml`   | `push` (to `release`), `workflow_dispatch` | Handles the deployment of project bundles to the production environment, including final validations and configurations, facilitating continuous deployment.   |

## Workflow Process and Connection Overview

### Development Phase:

- **Activity**: Developers push code to the `dev` branch.
- **Details**: This phase may include local tests and initial validations before moving the code to a shared environment.

### Pull Request Creation:

- **Activity**: Once development is completed in the `dev` branch, a pull request is created to merge the changes into the `main` branch.
- **Details**: This triggers several checks and workflows.

### Code Linting:

- **Workflow**: `lint-cicd-workflow-files.yml`
- **Trigger**: Pull requests that modify `.github/workflows/**`.
- **Activity**: Performs linting on the workflow files to ensure syntax correctness and prevent common configuration errors before the code is merged.

## Continuous Integration:

- **Workflow**: `LLMOps-bundle-ci.yml`
- **Trigger**: Pull requests.
- **Activity**: Validates the MLOps bundle configurations, ensuring all integration settings conform to required standards.
- **Details**: Checks configurations across all branches involved but primarily focuses on updates to the main branch. Includes validation steps that check both staging and production configurations to ensure consistency and readiness before deployment.

![image](/images/Projects/mlops/24_spring/group_2/image_7.webp)

## Testing:

- **Workflow**: `LLMOps-run-tests.yml`
- **Trigger**: Pull requests (on specific paths), `workflow_dispatch`.
- **Activity**: Runs unit and integration tests to validate code integrity and integration readiness, ensuring the codebase is reliable and functional.
- **Details**: Typically runs in a test or staging environment within Databricks to validate the code before it moves to the actual staging process.
  
![image](/images/Projects/mlops/24_spring/group_2/image_8.webp)

## Dev to Staging:

- **Workflow**: `LLMOps-bundle-cd-staging.yml`
- **Trigger**: Merge into `main`, `workflow_dispatch`.
- **Activity**: Manages the deployment of project bundles to the staging environment.
- **Details**: Includes steps to validate and deploy the bundle configurations in the staging environment, ensuring the deployment's readiness.

## Final Review and Merge to Release:

- **Activity**: After staging deployment and final validations, a pull request from `main` to `release` is created.
- **Details**: This merge is the final step before production deployment and triggers the production deployment workflows.

## Production Deployment:

- **Workflow**: `LLMOps-bundle-cd-prod.yml`
- **Trigger**: Push to `release`, `workflow_dispatch`.
- **Activity**: Manages the deployment of project bundles to the production environment.
- **Details**: Validates the bundle for production settings and deploys it, followed by running the actual production-level tasks (such as data processing or model training tasks defined in the Databricks notebooks).

![image](/images/Projects/mlops/24_spring/group_2/image_9.webp)

## Model Training Workflows Overview

The MLOps project utilizes several model training workflows defined in the `model_resources.yml` file. These workflows are integral to the CI/CD pipeline, ensuring that models are properly trained, evaluated, and deployed across different Databricks environments (test, staging, and production). Here's how these workflows are integrated within the GitHub Actions CI/CD setup:

## Overview of Model Workflows

The `model_resources.yml` file specifies the configuration for various machine learning tasks. These tasks are executed sequentially to process data, train models, evaluate their performance, and deploy them if they meet the criteria. Each task uses specific Databricks notebooks to perform its functions:

1. **PDF Advance Data Preparation**:
   - **Notebook**: `01_pdf_chuncks_embidings.ipynb`
   - **Function**: Processes PDF data into usable chunks and embeddings for further analysis.
   - **Execution Environment**: Uses an existing Databricks cluster (`existing_cluster_id: "0415-213012-yi87kqjn"`).
2. **Advanced Chatbot Chain**:
   - **Notebook**: `02_Advance_chabot_chain.ipynb`
   - **Function**: Utilizes the processed data to further the development of a chatbot.
   - **Dependencies**: Runs after the data preparation step.
3. **Offline Evaluation**:
   - **Notebook**: `03_offline_evaluation.ipynb`
   - **Function**: Evaluates the trained models or systems offline to ensure their effectiveness before deployment.
4. **Deploy Model As Endpoint**:
   - **Notebook**: `04_Deploy_model_as_endpoint.ipynb`
   - **Function**: Deploys the trained model as an accessible endpoint, once it passes the offline evaluation.

![image](/images/Projects/mlops/24_spring/group_2/image_22.webp)

## Integration with GitHub Workflows

The integration of these workflows within the CI/CD pipeline occurs as follows:
- **Test Environment Execution**: The `LLMOps-run-tests.yml` workflow triggers the execution of the model training jobs in the test environment. This includes running the above tasks to validate the functionality and reliability of the models before they are moved to staging.
- **Staging Deployment**: Upon successful tests and validation, the `LLMOps-bundle-cd-staging.yml` workflow deploys the bundle, including the trained models, to the staging environment. This stage is crucial for real-world testing under controlled conditions.
- **Production Deployment**: Finally, the `LLMOps-bundle-cd-prod.yml` workflow handles the deployment of the models to the production environment after ensuring that all criteria are met in the staging review. This workflow also triggers the final model training jobs in production, processing new data as needed.

![image](/images/Projects/mlops/24_spring/group_2/image_23.webp)

## Data Flow and Permissions

- **Data Sources**: The model training workflows utilize data from specific sources configured within the Databricks environments. Access to these data sources is controlled through permissions set in Databricks and the `model_resources.yml` file.
- **User and Service Principal Permissions**: Permissions are managed through service principals and user accounts to ensure secure and compliant data access and manipulation across environments.

This structured approach ensures that each step of model development and deployment is carefully monitored and controlled, integrating seamlessly with the overarching goals of the MLOps CI/CD pipelines.