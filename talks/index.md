---
layout: page
title: Talks
---

<ul class="posts">
  {% for post in site.posts %}
    {% if post.categories contains 'talks' %}
      <li>
        <small class="datetime muted" data-time="{{ post.date }}">{{ post.date | date_to_string }}</small>
        <a href="{{ post.url }}">{{ post.title }}</a>
      </li>
    {% endif %}
  {% endfor %}
</ul>
