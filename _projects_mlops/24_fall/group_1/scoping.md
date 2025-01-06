---
title: "2. Scoping"
featured_image: '/images/Projects/mlops/24_spring/group_2/16.webp'
---

## Table of Contents

1. [Introduction]({% link _projects/mlops/2024-01-01-f24-group-1.md %} ){:target="_blank"}<br>
2. [Scoping]( {% link _projects_mlops/24_fall/group_1/scoping.md %} ){:target="_blank"}<br>
3. [Data]( {% link _projects_mlops/24_fall/group_1/data.md %} ){:target="_blank"}<br>
4. [Modeling]( {% link _projects_mlops/24_fall/group_1/modelling.md %} ){:target="_blank"}<br>
5. [CI/CD]( {% link _projects_mlops/24_fall/group_1/ci-cd.md %} ){:target="_blank"}<br>
6. [Logging and Monitoring]( {% link _projects_mlops/24_fall/group_1/logging-and-monitoring.md %} ){:target="_blank"}<br>
7. [Cost Analysis]( {% link _projects_mlops/24_fall/group_1/cost-analysis.md %} ){:target="_blank"}<br>

## Dataset Information

We’ll use a dataset of reviews and metadata for video games and toys, sourced from Amazon product reviews. This dataset is essential for our eCommerce chatbot project, as it helps us understand customer experiences, preferences, and sentiments. By analyzing this data, we can improve the chatbot’s ability to provide relevant and accurate responses to user questions. Reviews in the dataset offer detailed customer feedback, while metadata provides key product information like categories, ratings, and prices—important for answering questions effectively.

With this data, we can create a smarter chatbot that offers personalized interactions based on customer feedback and product details. This approach will enhance user satisfaction and help boost sales by giving customers the information they need to make confident purchasing decisions.

## Current Approach

Many eCommerce platforms rely on basic search features and static FAQs, which often fail to provide users with specific or relevant insights, leading to frustration. While some companies use chatbots, these are typically limited to scripted responses and lack real-time data, resulting in generic and unhelpful interactions.

Efforts to curate reviews or highlight feedback often fall short, leaving users struggling to understand overall sentiment or find answers to specific questions. Without a smarter, more dynamic approach, platforms miss opportunities to enhance engagement and improve the shopping experience.

## Proposed Solution

Our solution is to create an intelligent eCommerce chatbot powered by Retrieval-Augmented Generation (RAG) for real-time, context-specific answers to customer questions. The chatbot will integrate seamlessly with the platform, activating when a user views a product. It will retrieve the relevant information using user reviews and product metadata to answer any queries the user asks.

The chatbot will handle queries about product details and provide personalized recommendations based on customer preferences and past reviews. Using a large language model (LLM) will generate coherent, engaging responses to enhance user satisfaction.

The chatbot will feature an intuitive interface, making it easy for users to interact and receive tailored information. By offering a virtual assistant that understands context and adapts to user needs, we aim to improve the shopping experience, build trust, and boost customer loyalty and conversions.

## Potential Bottlenecks

1. **Data Retrieval Latency:** Delays in fetching data from databases, especially when executing complex queries or dealing with large datasets.
2. **Resource-Intensive Vector Database Queries:** Prolonged response times when retrieving data from the vector database, particularly with large datasets or unoptimized retrieval methods.
3. **LLM Response Generation Latency:** Delays caused by the computational demands of the Large Language Model (LLM) when generating accurate and contextually appropriate answers.

## Solutions to Address Bottlenecks

1. **Optimize Database Queries:**
   - Ensure efficient query structures in the existing database system.
   - Use indexing or other optimization techniques available within the database to speed up data retrieval.
2. **Load Balancing:**
   - Distribute traffic evenly across multiple application instances using load balancers to maintain performance during high traffic periods.
3. **Model Optimization:**
   - Fine-tune the LLM using methods like model distillation or pruning.
   - Use smaller, optimized versions of the LLM, if possible, to improve response times.
4. **Performance Monitoring and Feedback:**
   - Use monitoring tools to track system performance and identify real-time bottlenecks.
   - Establish feedback loops for continuous improvement based on performance metrics and user interaction data.

## Business Goals

1. **Enhance Customer Experience:** Provide real-time, personalized responses to simplify product discovery and improve satisfaction, fostering brand loyalty.
2. **Boost Conversion Rates and Sales:** Address user concerns promptly to reduce cart abandonment, guiding users through their purchase journey and driving sales.
3. **Improve Operational Efficiency:** Automate routine inquiries, allowing human agents to focus on complex issues while maintaining service quality and reducing support costs.
4. **Provide Actionable Business Insights:** Collect and analyze data to inform decisions on product offerings, inventory, and marketing strategies.
5. **Foster Brand Loyalty and Engagement:** Create a personalized, engaging shopping experience that builds trust and customer retention, positioning the brand as an eCommerce leader.

## Objectives

- Develop an AI-driven chatbot to provide real-time, accurate answers to customer inquiries on video games and toys, enhancing the shopping experience.
- Personalize interactions for end customers by offering tailored product recommendations, improving satisfaction and conversion rates.
- Provide actionable insights for business owners and managers to optimize product offerings, marketing strategies, and inventory management.
- Streamline customer service operations by automating routine inquiries, freeing up agents for complex issues, and improving support efficiency.
- Ensure a user-friendly and intuitive interface for both customers and business stakeholders to enhance engagement and operational effectiveness.

## Success Metrics

This project focuses on implementing an intelligent eCommerce chatbot, incorporating Continuous Training (CT), alongside CI/CD, Continuous Monitoring (CM), and dynamic dashboards for real-time metrics. The success criteria can be streamlined as follows:

1. **User Engagement:**
   - Measure session duration and number of interactions per session.
   - Track the frequency of chatbot usage by unique users.
2. **Response Accuracy:**
   - Evaluate task success rates for user queries.
   - Collect and analyze user satisfaction scores.
3. **Customer Satisfaction:**
   - Conduct post-interaction surveys.
   - Monitor Net Promoter Scores (NPS) to gauge the likelihood of a recommendation.
4. **Conversion Rate:**
   - Track the percentage of users making purchases after chatbot interaction.
   - Analyze average order value for chatbot-assisted purchases.
5. **Latency and Response Time:**
   - Monitor time taken to respond to user queries.
   - Set targets for minimal delays to enhance user experience.
6. **Bias and Inference Monitoring:**
   - Implement tools to detect biases in LLM responses.
   - Conduct regular audits against predefined fairness benchmarks.
   - Collect and analyze user feedback to identify potential biases or inaccuracies.
7. **Automated CI/CD and Continuous Training (CT) Workflow:**
   - Measure the efficiency of data ingestion, model retraining, and deployment processes.
   - Track seamless integration and deployment of updates with minimal manual effort.
8. **Continuous Monitoring (CM) and Dashboards:**
   - Implement real-time monitoring of model performance and operational metrics.
   - Develop interactive dashboards for insights into model health and data quality.
   - Set up automated alerts for model drift, data anomalies, or performance degradation.