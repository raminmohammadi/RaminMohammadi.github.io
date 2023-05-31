---
title: Spring 2023
course: "IE 7300: Statistical Learning for Engineering"
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
---

{% assign projects = site.projects | where: "semester","23_spring" %}

| Project | Team |
|----------------|--------|{% for project in projects reversed %}
| [{{ project.title }}]({{ project.url }})|{{project.description}} |{% endfor %}