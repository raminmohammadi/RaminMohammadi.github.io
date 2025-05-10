---
title: MLOps Expo - Project Index
description: Top student teams from each semester's MLOps Expo
featured_image: /images/expo/IMG_6817.jpg
course: MLOps
---

{% assign projects = site.projects | where: 'expo', true %}

| Semester | Expo Date | View
|----------------|--------|{% for project in projects %}
| {{project.semester}} |{{project.expo_date}} | [Go to Expo →]({{ project.url }}) |{% endfor %}