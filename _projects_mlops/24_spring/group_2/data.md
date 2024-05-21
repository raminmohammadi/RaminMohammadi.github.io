---
featured_image: '//images/Projects/mlops/24_spring/group_2/Projects/mlops/23_fall/group_7/thumbnail.webp'
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

## Overview of Data Ingestion Pipeline

### Step 1: Data Ingestion

- **Method 1: Storing the data directly into ADLS Gen2**: Before running the pipeline the user can upload a set of pdfs directly into the storage blob (you can switch it to AWS S3). 
- **Method 2: Streamlit Web Application:** The initial stage involves setting up a Streamlit web application to serve as the front-end interface for data submission. This application facilitates the uploading of PDF and ZIP files through an intuitive user interface.

Inside the .env file, enter the variables as follows (make sure to replace the placeholders with your actual values):

```bash
streamlit run app.py
```

### Step 2: File Upload Processing

Upon receiving file uploads, the web application undertakes several key actions to ensure the data is correctly received and prepared for storage.
- **Upload Endpoint**: Streamlit's st.file_uploader component can be used for file uploads. Users can upload PDF and ZIP files using this component, which accepts files through a simple drag-and-drop interface or a file dialog. 
- **File Validation and Processing**:
  - Direct PDF uploads are stored in the "Ingested-PDFs" directory within the "pdfscontainer" container of Azure Blob Storage.
  - ZIP files undergo extraction, and each contained PDF is individually uploaded to the same Azure Blob Storage location, ensuring a structured and organized storage of the documents.

### Step 3: Integration with Azure Blob Storage

The Streamlit application interacts with Azure Blob Storage to store uploaded files, establishing a robust and scalable storage solution.
- **Connection Setup**: Using a provided connection string, the application connects to Azure Blob Storage, allowing file uploads to a specified container.
- **Blob Service Client**: Through the Azure SDK, the application employs `BlobServiceClient` to manage file uploads, ensuring that data is securely and efficiently stored in the cloud.

```bash
# Initialize Azure Storage client
blob_service_client = BlobServiceClient(account_url=connection_string, credential=azure_storage_account_key)
container_client = blob_service_client.get_container_client(azure_container_name)
```

### Step 4: Handling Anomalies and Alerts

In the data ingestion and processing pipeline, encountering anomalies and errors is inevitable. Addressing these issues proactively is crucial for maintaining the integrity and reliability of the pipeline. This section outlines the procedures for handling corrupted PDFs and unsupported file types.


![image](/images/Projects/mlops/24_spring/group_2/image_29.webp)

## Corrupted PDFs

PDF files, by their nature, are stored in binary format. When a corrupted PDF is encountered during the upload process to the Delta table, it's essential to have mechanisms in place to detect and handle the error effectively.
- **Detection**: Upon uploading, if the system encounters a corrupted PDF (e.g., files that are incomplete, damaged, or not conforming to the PDF specification), an error will be triggered during the attempt to convert the PDF's binary format to UTF-8 for text extraction and processing.
- **Resolution**: When a corrupted PDF is detected, the system should log the error, notify the relevant personnel or system via an alert, and exclude the corrupted file from further processing. This ensures that only valid and fully functional documents are ingested and processed.

## Handling Unsupported File Types

While the system is primarily designed to process PDF files, encountering other file types is a possibility that needs to be addressed.
- **Unsupported File Types**: If a file that is not a PDF (e.g., text files, images, etc.) is uploaded, the system should have checks in place to identify and segregate these files.
- **Processing Text Files**: In cases where text files are acceptable and can be processed, the system should include a workflow to handle these files separately, extracting their content for ingestion and processing in a manner similar to PDFs but adjusted for the differences in file format.

## Alert Mechanism

For both scenarios outlined above, implementing an effective alert mechanism is vital. The mechanism would involve:
- Notify system administrators or designated users of the issue, providing details about the corrupted file or unsupported file type encountered.
- Log the incidents in a monitoring system for auditing and troubleshooting purposes.

By establishing clear protocols for handling corrupted PDFs and unsupported file types, the system ensures data quality and operational efficiency while minimizing disruptions to the data ingestion and processing pipeline.
- **Success and Error Messages**: The application communicates the outcome of the upload process to the user, displaying messages that confirm successful uploads or detail any errors encountered, such as file format issues or storage errors.

### Step 5: Data Ingestion with Auto Loader

The integration with Auto Loader facilitates the efficient processing of newly arrived data files in cloud storage.

- **From ADLS Gen2 to Databricks**:
  - **Auto Loader Utilization**: Auto Loader is employed to incrementally and efficiently process new data files as they arrive in cloud storage, supporting a variety of file formats and storage solutions.
  - **Ingesting PDF Documents**: Auto Loader is specifically configured to ingest PDF documents stored in Azure Blob Storage, transforming them into a Delta Lake table with paths and binary content. This enables the structured storage and accessibility of unstructured PDF data.
- **Key Components of Auto Loader Configuration**:
  - **Format Specification** ('cloudFiles'): Directs Spark to utilize Auto Loader for data ingestion.
  - **File Format** ('BINARYFILE'): Ensures PDF documents are ingested in binary form.
  - **Path Glob Filter** ("*.pdf"): Filters files for ingestion based on their extension, specifically targeting PDF files.
  - **Data Load Path**: Identifies the specific location within Databricks File System (DBFS) from which Auto Loader should ingest files.
  - **Checkpoint Location**: Tracks ingestion progress to enable incremental processing and ensure data integrity.
  - **Delta Table Output** (`table('pdf_raw')`): The destination Delta Lake table where ingested PDF content is stored, facilitating structured analysis of unstructured data.

```bash
df = (spark.readStream
                .format('cloudFiles')
                .option('cloudFiles.format', 'BINARYFILE')
                .option("pathGlobFilter", "*.pdf")
                .load('/mnt/datafromazure/Test_1_PDF/'))
 
        (df.writeStream
        .trigger(availableNow=True)
        .option("checkpointLocation", new_checkpoint_dir)
        .table('pdf_raw').awaitTermination())
```

## Data Version Control

Data Version Control is integral to managing and tracking the evolution of data throughout the ingestion and processing pipeline. It encompasses enabling Change Data Feed (CDF), leveraging Time Travel, and automating data versioning with Delta Lake.

## Enabling Change Data Feed (CDF)

**Change Data Feed (CDF)** plays a crucial role in the data lifecycle management by tracking and recording row-level changes (inserts, updates, deletes) within tables. This feature is pivotal for:
- **Incremental Processing**: Efficiently processing only the changed data, reducing computational overhead and speeding up data pipelines.
- **Data Evolution Analysis**: Understanding how data evolves over time by providing a detailed record of changes.
- **Reconstructing Data States**: Offering the ability to reconstruct the state of the data at any point in time, which is essential for auditing, rollback, and historical analysis.


## Time Travel for Accessing Historical Data

Delta Lake introduces a powerful feature known as **Time Travel** that allows for accessing historical data through automatic versioning upon each write operation.

**How Time Travel Works:**

Whenever data is written to a Delta table, Delta Lake versions this data. This automatic versioning mechanism is key for:
- **Time Travel**: This enables accessing the table as it was at a specific point in time, leveraging either a version number or a timestamp. It's particularly useful for auditing purposes, data recovery, and analyzing how data evolves over time.
- **Auditing Changes**: The `DESCRIBE HISTORY` command in Delta Lake provides a detailed log of all changes made to the table. This log includes information on the creation of new versions and the exact timestamps of these changes.


### Step 6: Content Extraction and Preprocessing

Following data ingestion, the next phase involves extracting and preparing the textual content for further processing.

- **Text Extraction**: Utilizing the unstructured library within a Spark User-Defined Function (UDF), we parse the binary data of PDF documents to extract textual content. This process accounts for the complexities inherent in PDF formats, including handling image-based content through Optical Character Recognition (OCR) if necessary.
- **Chunking**: After text extraction, the content is divided into manageable chunks. This is achieved using another Spark UDF, applying strategies from tools like llama_index or Langchain to ensure each chunk is of appropriate size for subsequent processing.

```bash
def read_as_chunk(batch_iter: Iterator[pd.Series]) -> Iterator[pd.Series]:
    #set llama2 as tokenizer to match our model size (will stay below BGE 1024 limit)
    set_global_tokenizer(
      AutoTokenizer.from_pretrained("hf-internal-testing/llama-tokenizer")
    )
    #Sentence splitter from llama_index to split on sentences
    splitter = SentenceSplitter(chunk_size=500, chunk_overlap=50)
    def extract_and_split(b):
      txt = extract_doc_text(b)
      nodes = splitter.get_nodes_from_documents([Document(text=txt)])
      return [n.text for n in nodes]

    for x in batch_iter:
        yield x.apply(extract_and_split)
```

### Step 7: Embedding Computation

With textual data segmented, the next step is to compute embeddings for each chunk, transforming the textual data into a vector space.

- **Foundation Model for generating Embedding**: Databricks BGE (Big Model Embeddings) Foundation Model endpoints are employed to generate embeddings, leveraging advanced AI models to convert text chunks into high-dimensional vectors.
- **Embedding Storage**: The computed embeddings, along with the original text chunks, are stored in a Delta Lake table `databricks_pdf_documentation`. This structured format enables efficient vector search indexing and retrieval processes.

### Step 8: Vector Search Indexing

The development of a Self-Managed Vector Search Index marks the next phase, enhancing the pipeline's ability to perform efficient similarity searches.

- **Index Creation**: Using Databricks Vector Search, we configure and establish a Self-Managed Vector Search Index, key to enabling efficient similarity searches.
- **Delta Lake Integration**: The Delta Lake table, now containing both text chunks and their embeddings, is synchronized with the Vector Search Index. This ensures updates to the data are reflected within the index, maintaining the accuracy and relevancy of search results.

### Step 9: Similarity Search and Retrieval

The culmination of the pipeline is the use of computed embeddings to perform similarity searches against the Vector Search Index, identifying the most relevant documents or text chunks for specific queries.

- **Query Processing**: Queries are transformed into embeddings, comparable to those of the stored documents, enabling the identification of semantically similar content.
- **Security and Filtering**: The similarity search includes support for filters, allowing for content-sensitive retrieval based on criteria like user permissions or content relevance.

```bash
question = "How can I track billing usage on my workspaces?"

response = deploy_client.predict(endpoint="databricks-bge-large-en", inputs={"input": [question]})
embeddings = [e['embedding'] for e in response.data]

results = vsc.get_index(VECTOR_SEARCH_ENDPOINT_NAME, vs_index_fullname).similarity_search(
  query_vector=embeddings[0],
  columns=["url", "content"],
  num_results=1)
docs = results.get('result', {}).get('data_array', [])
pprint(docs)
```