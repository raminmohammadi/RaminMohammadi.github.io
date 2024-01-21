---
title: Projects - Table of Contents
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
course: MLOps
---

<!-- {% assign terms = site.projects_toc_mlops %}

| Semester | Course |
|--------|----------|{% for term in terms %}
| [{{ term.title }}]({{ term.url }}) | {{ term.course }} |{% endfor %} -->

## Fall 2023

{% assign projects = site.projects | where: "semester","23_fall"  | where: 'course', 'MLOps' %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}