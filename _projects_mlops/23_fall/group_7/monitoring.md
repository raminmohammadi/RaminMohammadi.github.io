---
featured_image: '/images/Projects/mlops/23_fall/group_7/thumbnail.webp'
---

### Outline:
1. [Introduction]({% link _projects/2024-01-01-f23-group-7.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/23_fall/group_7/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/23_fall/group_7/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/23_fall/group_7/modeling.md %} ){:target="_blank"}<br>
5. [Deployment]( {% link _projects_mlops/23_fall/group_7/deployment.md %} ){:target="_blank"}<br>
6. [Monitoring]( {% link _projects_mlops/23_fall/group_7/monitoring.md %} ){:target="_blank"}<br>

### 1. Pipeline

![Monitoring Graph](/images/Projects/mlops/23_fall/group_7/Monitoring_grpah.webp "Monitoring Graph")

Our real-time monitoring pipeline starts off by storing data that is used to call the `predict.py` function into a GCS bucket. BigQuery reads this data and makes it available to use to analyze using SQL. We connect BigQuery with Looker Studio to give us a Looker Dashboard to monitor Data/concept drift (if applicable) 

### 2. Dashboard Setup

We developed a Monitoring Dashboard to actively track any alterations in our data and to monitor the concept of data drift. Our approach involves leveraging BigQuery to persistently store our input values. Subsequently, we connect Looker to BigQuery, enabling us to generate insightful charts from this stored data.

In addition, we have incorporated specific functions within our prediction module to capture and store vital metrics. These metrics encompass essential factors such as prediction latency, the minimum value of each feature, and the maximum value of each feature.

Our charts break down each feature by displaying not only the median value but also the average value. Additionally, we pinpoint any values that exceed the maximum or fall below the minimum, providing a visual cue for potential outliers. Beyond feature details, we incorporate a visualization highlighting the average latency associated with our predictions. This comprehensive approach not only enhances the clarity of our feature analyses but also sheds light on the average time it takes for our predictions to be processed. 

[Looker](https://lookerstudio.google.com/u/0/reporting/14d7886c-3581-4e2f-b2cc-1a3d27614b8d/page/p_gvmoucxlcd?s=tsXALSpVJ3w)

![Monitoring Graph PC3](/images/Projects/mlops/23_fall/group_7/Monitoring_Grpahs_PC3.webp "Monitoring Graph PC3")

From above charts we can see that 2 records have an outlier for PC3. The Max value for PC3 is 4.1 and 2 values are above that. Also, we can see that average value of PC3 is 0.03.

![Monitoring Graph Latency](/images/Projects/mlops/23_fall/group_7/Monitoring_Graphs_Latency.webp "Monitoring Graph Latency")


