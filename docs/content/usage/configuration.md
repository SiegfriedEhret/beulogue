---
title: Configuration
date: 2019-05-25
description: The configuration file
weight: 1.4
---

The configuration file for your site must be `beulogue.yml`.

Example:

```yaml
base: https://ehret.me
title: My site
languages:
- en
- fr
```

The mandatory possible keys and values are:

- **base** (string): the base url of your website.
- **title** (string): the title of your website.
- **languages** (array of strings): the list of languages for the website. You must add at least one language; the first one is the default one.

The optional ones are:

- **rssFilename** (string): the name for the rss feed (default: `feed.xml`)
- **sortPagesBy** (string): `date` or `weight`, set the property to sort the pages (default: `date`).
- **sortPagesOrder** (string): `asc` or `desc`, set the sorting order (default: `desc`).

[⬅️ structure](/en/usage/structure.html) || [content ➡️](/en/content/index.html)