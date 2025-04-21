---
title: MLOps Expo - Project Index
description: Top student teams from each semester's MLOps Expo
featured_image: /images/mlops/expo_banner.jpg
course: MLOps
---

## Spring 2025

{% assign spring_projects = site.projects_mlops_expo | where: "semester", "25_spring" | where: "course", "MLOps" %}
{% for project in spring_projects %}
{{ project.content }}
{% endfor %}

---

## Fall 2024

{% assign fall_projects = site.projects_mlops_expo | where: "semester", "24_fall" | where: "course", "MLOps" %}
{% for project in fall_projects %}
{{ project.content }}
{% endfor %}
