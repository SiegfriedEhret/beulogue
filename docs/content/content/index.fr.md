---
title: Contenu
date: 2019-06-29
description: Tous sur les contenus dans beulogue
weight: 2.0
---

## Où

Les contenus doivent se trouver dans le dossier `content` de votre site.

## Format

Le format attendu est [markdown (`.md`)](https://fr.wikipedia.org/wiki/Markdown) ou [gemini (`.gmi`)](https://gemini.circumlunar.space/docs/specification.html) (voir chapitre 5).

## Résultat

Les fichiers de sortie auront le même nom que vos fichiers markdown ou gemini. Ils se terminent par `.html` au lieu de `.md` ou `.gmi`, bien entendu.

## Extra

Vous pouvez injecter du contenu dans vos modèles de page en utilisant un fichier `_index.md` (pour la langue principale) ou `_index.LANG.md` pour une langue `LANG` donnée (par exemple: `_index.fr.md` pour le français). Idem pour un fichier `.gmi` !

[⬅️ configuration](/fr/usage/configuration.html) || [matière liminaire ➡️](/fr/content/front-matter.html)