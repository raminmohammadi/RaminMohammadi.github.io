---
title: Fall 2023
course: "IE 7374: Machine Learning Operations(MLOps)"
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
---

{% assign projects = site.projects | where: "semester","23_fall"  | where: 'course', 'MLOps' %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}

{% assign projects = site.projects | where: "semester","24_spring"  | where: 'course', 'MLOps' %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}