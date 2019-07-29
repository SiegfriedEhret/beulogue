---
title: Matière liminaire
date: 2019-06-29
description: Comment utiliser la matière liminaire
weight: 2.1
---

Vous pouvez utiliser la matière liminaire (en anglais: front matter) dans vos billets, comme suivant:

```
---
title: Mon titre
date: 2019-05-07
description: Une petite description
tags:
- news
orphan: false
weight: 1.0
---

# Mon contenu...
```

Les propriétés suivantes sont nécessaires:

- **title** (chaîne de caractères): le titre du billet.
- **date** (chaîne de caractères): un point dans le temps, utilisé pour trier les contenus ([plus d'information sur le format, en anglais](https://yaml.org/type/timestamp.html)).
- **description** (chaîne de caractères): une petite description, utilisée pour le flux rss par exemple.

Les propriétés suivantes sont optionnelles:

- **orphan** (`true` or `false`): mettre à `true` pour que les pages soient construites mais non incluses dans le modèle de page correspondant à la liste.
- **tags** (liste de chaînes de caractères): quelques étiquettes pour catégoriser votre billet.
- **weight** (nombre flottant): le poids de la page, peut être utilisé pour le tri des billets. La valeur par défaut est `1.0`.

[⬅️ contenu](/fr/content/index.html) || [Raccourcis ➡️](/fr/content/shortcodes.html)