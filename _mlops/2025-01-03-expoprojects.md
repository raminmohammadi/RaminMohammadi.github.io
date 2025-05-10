---
layout: default
title: MLOps Expo
description: View top student projects from each semester's MLOps Expo
featured_image: /images/expo/IMG_6817.jpg
---

<section class="hero">
  <div class="hero__image" style="background-image: url({{ page.featured_image | relative_url }})">
    <div class="hero__overlay"></div>
  </div>

  <div class="wrap">
    <h1>MLOps Expo Archive</h1>
    <p>Explore top student teams and projects presented at each semester’s MLOps Expo.</p>
  </div>
</section>

<section class="single">

	<div class="wrap">

		<article class="single-post">

		{%- assign page = site.pages | where: 'title', 'MLOps Expo - Project Index' | where: 'course', 'MLOps' | first -%}
		{{page.content}}

		</article>

	</div>

</section>
