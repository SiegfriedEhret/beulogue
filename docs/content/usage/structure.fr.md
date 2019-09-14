---
title: Structure
date: 2019-10-14
description: Comment structurer votre projet
weight: 1.3
---

Votre site doit avoir la structure suivante:

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
└── templates
    ├── list.html
    └── page.html
```

- `beulogue.yml` est un fichier de configuration nécessaire.
- `content/` est le répertoires contenant toutes vos pages.
- `templates/` est le répertoire avec vos modèles HTML.

[⬅️ utilisation](/fr/usage/usage.html) || [configuration ➡️](/fr/usage/configuration.html)