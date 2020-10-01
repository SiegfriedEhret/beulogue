---
title: Shortcodes
date: 2019-05-25
description: How to use shortcodes
weight: 2.2
---

Shortcodes are small things that you can use in your contents.

## Internal contents

- **Reference**: use `{{ "{{ ref(\"path/to/content.md\") }}" }}` to generate a link to this content.
	- :warning: if you reference a link to the current content, beulogue will crash.
	- beulogue will give you a warning if you reference a non existing content.

## External contents

- **Dailymotion**: use `{{ "{{ dailymotion(\"12345\") }}" }}` to embed a [Dailymotion](https://www.dailymotion.com/) video.
- **GitHub Gist**: use `{{ "{{ gist(\"beulogue\", \"123456\") }}" }}` to embed a [Gist](https://help.github.com/en/articles/about-gists).
- **vimeo**: use `{{ "{{ vimeo(\"12345\") }}" }}` to embed a [Vimeo](https://www.vimeo.com/) video.
- **YouTube**: use `{{ "{{ youtube(\"12345\") }}" }}` to embed a [YouTube](https://www.youtube.com/) video.

[⬅️ front matter](/en/content/front-matter.html) || [emojis ➡️](/en/content/emojis.html)
