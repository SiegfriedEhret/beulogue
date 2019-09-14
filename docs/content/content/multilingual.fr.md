---
title: Site multi-langues
date: 2019-10-14
description: Comment créer un site multi-langues
weight: 2.5
---

Comme décrit dans la partie Configuration, il faut nécessairement une langue de base, utile pour l'attribut `lang` par exemple.

Si votre configuration est comme ceci:

```yaml
base: https://ehret.me
title: My site
languages:
- en
- fr
```

Vos contenus:

- En *anglais* (ici `en`, la première langue de la liste): les noms de fichiers auront la forme `about.md` (pas de mention de la langue dans le nom du fichier).
- En *d'autres langues* (ici `fr`): les noms de fichiers auront la forme `about.fr.md`.
- Les fichiers ayant un suffixe de langue non décrit dans la configuration seront affectés à la langue par défaut; dans notre exemple, `en`.

Structure:

- Si vous avez une seule langue: tout sera généré dans le répertoire `public`. Un fichier `feed.xml` sera aussi créé dans ce répertoire.
- Si vous avez plusieurs langues: le site pour chaque langue sera généré dans un répertoire de nommé `public/<language>/`. Un fichier `index.html` sera ajouté dans le répertoire `public/`, et redirigera vers la langue par défaut. Un fichier `feed.xml` sera créé pour chaque langue.

[⬅️ modèles de pages](/fr/content/templating.html) || [notes ➡️](/fr/other/notes.html)
