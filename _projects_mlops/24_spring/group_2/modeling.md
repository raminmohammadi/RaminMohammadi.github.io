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

## Advance Chatbot Chain

### Step 1: Exploring Langchains

**Agent and Chain Mechanics**:
- **Agent**: In the context of Langchain, an agent is a central component that manages interactions by processing inputs (questions or commands) and producing outputs (answers or actions). An agent can be thought of as the conductor of a chatbot or conversational AI system, orchestrating the flow of information through various processes and decision-making paths.
- **Chain**: A chain refers to a sequence of processing steps configured within Langchain to handle specific types of tasks or queries. Each chain can be customized with different processing steps (like retrieval, parsing, and answering), which are executed in a defined order to handle the input and generate the appropriate output. Chains enable modular and flexible design, allowing complex conversational logic to be built up from simpler components.

### Step 2: Dealing with Hallucinations

To maintain the relevance and accuracy of the chatbot's responses, especially in a professional or business environment, it's crucial to filter out irrelevant or out-of-scope questions:
- **Relevant Question Chain**: Activated when the incoming question is identified as pertinent to the company's domain. This chain processes the question, retrieves relevant documents or data, and generates a response that is informed by this information.
- **Irrelevant Question Chain**: Used when the question is deemed irrelevant to the company's focus areas. This chain provides a standard response indicating that the question does not pertain to the company’s services or expertise, thus maintaining the conversation's focus and preventing the AI from generating misleading or incorrect information.

### Step 3: Conversation History to Prompt

**History Integration**:
- The chatbot incorporates a user's conversation history to provide context to the responses. By understanding the flow of the conversation and the topics discussed previously, the chatbot can generate more accurate and contextually appropriate responses. This method helps in maintaining continuity in conversations and avoids repetitive or conflicting information.

### Step 4: Improved Document Retrieval Based on Chat History

**Document Vector Retrieval**:
- This process enhances the retrieval of documents by using both the current query and the chat history as inputs. By considering the broader context provided by the conversation history, the system can perform more targeted searches, improving the relevance of the documents it retrieves and thus the quality of the information provided in responses.

### Step 5: Retrieving Docs from Vector Store

**Top Document Retrieval**:
- The system uses vector search technology to identify and retrieve documents that are most semantically similar to the query, based on cosine similarity metrics. This approach ensures that the documents fetched are highly relevant to the current user query, facilitating more accurate and informative answers.

### Step 6: Registering Model to Unity Catalog through MLflow

**Experiment Run and Model Logging**:
- This step involves using MLflow, a platform to manage the ML lifecycle, including experimentation, reproducibility, and deployment. Chatbot models are rigorously tested and their parameters logged during experiments. This detailed recording facilitates understanding model behavior and ensures that the model can be reliably reproduced and deployed.

### Step 7: Invoking the Model

**Model Deployment and Invocation**:
- Once the model is fully trained, tested, and registered, it is deployed into a production environment where it can be invoked to handle real-world interactions. The model can be loaded and executed to respond to user inputs, completing the cycle from development to deployment.