---
featured_image: '/images/Projects/mlops/24_spring/group_3/thumbnail.webp'
---

# Table of Contents

1. [Introduction]({% link _projects/mlops/2024-01-02-s24-group-3.md %} )<br>
2. [Scoping]( {% link _projects_mlops/24_spring/group_3/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/24_spring/group_3/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/24_spring/group_3/modeling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/24_spring/group_3/deployment.md %} ){:target="_blank"}<br>
6. [Monitoring]( {% link _projects_mlops/24_spring/group_3/monitoring.md %} ){:target="_blank"}<br>

Once models are deployed, continuous monitoring is essential to ensure they perform as expected in a live environment. This involves tracking performance metrics such as latency, throughput, and error rates in real-time. We utilize Google Cloud Monitoring to set up custom dashboards and alerts that help in proactively identifying and resolving issues. This approach not only helps in maintaining the reliability of our models but also ensures that they continue to meet the required accuracy and performance standards over time.


## 1. Cluster Health Monitoring
Our deployment architecture is built on Cloud Composer running on Google Kubernetes Engine (GKE) backend, which provides robust, scalable management for containerized applications using Kubernetes. To oversee the health and performance of these clusters, we leverage Google-managed services such as Prometheus, which is integrated into GKE as part of Google Cloud Operations suite. Prometheus allows us to collect and store metrics as time series data, providing valuable insights into the health and performance of our clusters. Below are the list of Key Performance Indicators (KPIs) and metrics used to monitor them:

1. Memory Usage and Utilization
	- KPI: Monitoring memory usage to ensure the service stays within allocated limits.
	- Metrics:
		1. Memory Utilization (%): Shows peaks and average memory usage over time.
		2. Memory Limit Exceeded: Indicates when memory usage exceeds the set limit, which can lead to service crashes or performance degradation.
2. Request Metrics
	- KPI: Assessing the volume and performance of HTTP requests handled by the service.
	- Metrics:
		1. Request Count: High request counts indicate heavy usage; breakdown by status codes helps identify potential issues (e.g., many 5xx errors).
		2. Request Latencies: Measures the time taken to process requests. Lower latencies indicate better performance.
3. Container Instances
	- KPI: Ensuring sufficient instances are running to handle the load without over-provisioning.
	- Metrics:
		1. Instance Count: Tracks the number of active versus idle instances, helping in scaling decisions.
		2. Billable Instance Time: Helps manage costs by tracking the duration instances are billable.
4. CPU Utilization
	- KPI: Optimizing CPU usage to balance performance and cost.
	- Metrics:
		1. CPU Utilization (%): Monitors how much CPU is used, helping to identify if the service is over- or under-utilized.
5.	Data Transfer Metrics
	- KPI: Monitoring data throughput to ensure that the network can handle the load.
	- Metrics:
		1. Sent Bytes: Amount of data sent by the service.
		2. Received Bytes: Amount of data received by the service.
6.	Concurrency and Latency
	- KPI: Ensuring the service can handle concurrent requests efficiently and starts new instances quickly when needed.
	- Metrics:
		1. Max Concurrent Requests: Indicates the load in terms of simultaneous requests.
		2. Startup Latency: Time taken for new instances to become ready, impacting the ability to scale quickly.

![cluster_health_1](/images/Projects/mlops/24_spring/group_3/cluster_health_1.webp)

![cluster_health_2](/images/Projects/mlops/24_spring/group_3/cluster_health_2.webp)

## 2. Monitoring and Dashboard Setup

This setup enables us to:
- **Monitor Resource Utilization**: We can track CPU, memory, and storage usage across all nodes in the cluster to prevent overallocation or bottlenecks.
- **Alerts for Anomalies**: We can configure alerts for abnormal behaviors, such as spikes in resource usage or unexpected downtimes, ensuring quick response times to potential issues.
- **Visualize Metrics**: We use Google Cloud's built-in dashboard tools to create visual representations of our monitoring data, making it easier to understand and react to metrics.
- **Automate Responses**: We also implement automated scaling and balancing based on the workload demands and predefined rules in response to real-time metrics, improving the resilience and efficiency of our applications.

![resource_util](/images/Projects/mlops/24_spring/group_3/resource_util.webp)