---
title: Raccourcis
date: 2019-10-14
description: Comment utiliser les raccourcis
weight: 2.2
---

Les raccourcis (en anglais «shortcodes») sont des petits code à utiliser dans vos contenus.

## Contenus internes

{{=<% %>=}}
- **Référence**: utiliser `{{>ref chemin/vers/autre-contenu.md}}` pour générer un lien vers cet autre contenu.
	- :warning: une référence d'un contenu vers le même contenu va casser beulogue.
	- beulogue affichera un message si une référence pointe vers un contenu inexistant.
<%={{ }}=%>

## Contenus externes

{{=<% %>=}}
- **Dailymotion**: utiliser `{{>dailymotion 12345}}` pour intégrer une vidéo depuis [Dailymotion](https://www.dailymotion.com/).
- **GitHub Gist**: utiliser `{{>gist beulogue 123456}}`pour intégrer un élément depuis [Gist](https://help.github.com/en/articles/about-gists).
- **vimeo**: utiliser `{{>vimeo 12345}}` pour intégrer une vidéo depuis [Vimeo](https://www.vimeo.com/).
- **YouTube**: utiliser `{{>youtube 12345}}` pour intégrer une vidéo depuis [YouTube](https://www.youtube.com/).
<%={{ }}=%>

[⬅️ matière liminaire](/fr/content/front-matter.html) || [emojis ➡️](/fr/content/emojis.html)
