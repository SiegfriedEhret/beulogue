---
title: Configuration
date: 2019-10-14
description: Le fichier de configuration
weight: 1.4
---

Le fichier de configuration pour votre site doit être `beulogue.yml`.

Exemple:

```yaml
base: https://ehret.me
title: Mon site
languages:
- en
- fr
```

Les clés/valeurs obligatoires sont:

- **base** (chaîne de caractères): l'url de base de votre site.
- **title** (chaîne de caractères): le titre de votre site.
- **languages** (lsite de chaînes de caractères): la liste des langues pour votre site. Vous devez en préciser une; la première est la langue par défaut.

Les optionnelles sont:

- **rssFilename** (chaîne de caractères): le nom du fichier RSS (valeur par défaut: `feed.xml`)
- **sortPagesBy** (chaîne de caractères): `date` ou `weight`, pour choisir selon quelle propriété ordonner les pages (valeur par défaut: `date`).
- **sortPagesOrder** (chaîne de caractères): `asc` ou `desc`, pour choisir le sens de tri (valeur par défaut: `desc`).

[⬅️ structure](/fr/usage/structure.html) || [contenus ➡️](/fr/content/index.html)