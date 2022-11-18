---
title: Summer 2022
course: "IE 7374: Machine Learning in Engineering"
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
---

{% assign projects = site.projects | where: "semester","22_summer" %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}    