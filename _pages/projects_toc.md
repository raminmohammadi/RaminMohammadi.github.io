---
title: Projects - Table of Contents
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
---

{% assign terms = site.projects_toc %}

| Semester | Course |
|--------|----------|{% for term in terms %}
| [{{ term.title }}]({{ term.url }}) | {{ term.course }} |{% endfor %}