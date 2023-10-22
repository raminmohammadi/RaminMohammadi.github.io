---
title: Blogs - Table of Contents
subtitle: 
description: 
featured_image: /images/demo/contact.jpg
course: ML
---

## Linear Algebra, Probability and Statistics

{% assign math_posts = site.posts | where: "categories","math" %}

| Blog | Author |
|----------------|--------|{% for post in math_posts reversed %}
| [{{ post.title }}]({{ post.url }})|{{post.author}} |{% endfor %}

## Optimization Techniques

{% assign math_posts = site.posts | where: "categories","optimization" %}

| Blog | Author |
|----------------|--------|{% for post in math_posts reversed %}
| [{{ post.title }}]({{ post.url }})|{{post.author}} |{% endfor %}

## Machine Learning

{% assign ml_posts = site.posts | where: "categories","ml" %}

| Blog | Author |
|----------------|--------|{% for post in ml_posts reversed %}
| [{{ post.title }}]({{ post.url }})|{{post.author}} |{% endfor %}

## Natural Language Processing

{% assign nlp_posts = site.posts | where: "categories","nlp" %}

| Blog | Author |
|----------------|--------|{% for post in nlp_posts reversed %}
| [{{ post.title }}]({{ post.url }})|{{post.author}} |{% endfor %}