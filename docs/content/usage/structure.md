---
title: Structure
date: 2019-05-25
description: How to structure your files
weight: 1.3
---

Your website must be something like:

```
my-website
├── beulogue.yml
├── content
│   ├── 2019
│   │   ├── 05
│   │   │   └── may.md
│   │   └── jtutu.md
│   ├── about.fr.md
│   ├── about.jp.md
│   └── about.md
├── drafts
│   └── next-article.md
└── templates
    ├── list.html
    ├── page.html
    └── tags.html (optional)
```

- `beulogue.yml` is a mandatory configuration file.
- `content/` is the folder with all your pages.
- `drafts/` is the folder with all your drafts (only considered when using `beulogue -dev`).
- `templates/` is the folder for your templates.

[⬅️ usage](/en/usage/usage.html) || [configuration ➡️](/en/usage/configuration.html)