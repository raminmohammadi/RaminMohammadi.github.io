---
title: MLOps Expo - Project Index
description: Top student teams from each semester's MLOps Expo
featured_image: /images/mlops/expo_banner.jpg
course: MLOps
---

## Spring 2025

{% assign expo projects = site.projects_mlops_expo | where: "semester", "25_spring" | where: "course", "MLOps" %}
{% for project in projects %}
{{ project.content }}
{% endfor %}

---

## Fall 2024

{% assign expo projects = site.projects_mlops_expo | where: "semester", "24_fall" | where: "course", "MLOps" %}
{% for project in projects %}
{{ project.content }}
{% endfor %}
