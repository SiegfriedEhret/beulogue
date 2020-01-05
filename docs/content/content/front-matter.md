---
title: Front matter
date: 2019-05-25
description: How to use front matter
weight: 2.1
---

You can use front-matter, like that:

```
---
title: My title
date: 2019-05-07
description: A small description
tags:
- news
orphan: false
weight: 1.0
---

# My content...
```

The following properties are all mandatory:

- **title** (string): the title for your content item.
- **date** (string): a point in time, used to sort your content items ([more info on the format](https://yaml.org/type/timestamp.html)).
- **description** (string): a small description, used for the rss feed for example.

The following properties are optional:

- **orphan** (`true` or `false`): set to `true` and your page will be rendered but not included in the list templates.
- **tags** (array of string): some tags for your content. Tags pages will be generated from a custom `tags.html` template or the `list.html` one.
- **weight** (float number): weight of the page, used for sorting. Default is `1.0`.

[⬅️ content](/en/content/index.html) || [shortcodes ➡️](/en/content/shortcodes.html)