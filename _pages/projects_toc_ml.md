---
title: Projects - Table of Contents
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
course: ML
---

<!-- {% assign terms = site.projects_toc_ml %}

| Semester | Course |
|--------|----------|{% for term in terms %}
| [{{ term.title }}]({{ term.url }}) | {{ term.course }} |{% endfor %} -->

## Spring 2023

{% assign projects = site.projects | where: "semester","23_spring" %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}

## Fall 2022

{% assign projects = site.projects | where: "semester","22_fall" %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}

## Summer 2022

{% assign projects = site.projects | where: "semester","22_summer" %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %} 