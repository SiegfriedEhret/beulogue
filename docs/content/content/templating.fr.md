---
title: Modèles de pages
date: 2019-10-14
description: Modèles de pages avec Crinja
weight: 2.4
---

Vous devez fournir 2 fichiers html, qui doivent être placés dans le dossier `templates` de votre projet.

- `list.html`: pour la liste des contenus
- `page.html`: pour un contenu

L'outil utiliser pour les modèles est quasiment identique à [Jinja](https://jinja.palletsprojects.com/en/2.11.x/), via la librairie [Crinja](https://straight-shoota.github.io/crinja/).

### Templating 101

Si une variable nommée `title` est disponible, utilisez `{{ "{{ title }}" }}` dans le template pour afficher sa valeur.

Si vous avez une variable `pages` qui est une liste d'objets avec une propritété `title`, vous pouvez bouclez sur la liste comme tel:

```
{{ "{% for page in pages %}
  {{ page.title }}
{% endfor %}" }}
```

Si vous souhaitez un affichage conditionnel pour `title` en fonction de si elle a une valeur ou non, utilisez:

```
{{ "{% if title %}
  Title is displayed ! {{ title }}
{% endif %}" }}
```

Rendez-vous sur l'[aide mustache](https://mustache.github.io/mustache.5.html) pour plus d'info.

### Variables pour le modèle de page de contenu

- `title`: le titre du contenu, depuis la matière liminaire.
- `date`: la date du contenu, depuis la matière liminaire.
- `dateFormatted`: la même chose, sous la forme suivante `YYYY-MM-DD`.
- `content`: la contenu en html.
- `contentPath`: le chemin vers le contenu, relatif au répertoire `content`.
- `language`: la langue du contenu.
- `multilang`: une liste d'objets avec les propriétés suivantes:
	- `language`: une langue (comme dans le fichier beulogue.yml).
	- `url`: l'url pour la langue associée.
- `url`: l'url de la page.
- `site`
	- `title`: le titre du site.
	- `languages`: une liste des langues disponibles pour le site.
- `beulogue`
	- `cwd`: le chemin courant.

### Variables pour le modèle de liste

- `pages`: une liste d'éléments tels que décrits dans la partie ci-dessus, `content` n'est pas présent dans ce cas.
- `language`: la langue de la page.
- `site`
	- `title`: le titre du site.
	- `languages`: une liste des langues disponibles pour le site.
- `beulogue`
	- `cwd`: le chemin courant.

Si vous utilisez la foncitonnalité `_index.md` ou `_index.LANG.md` pour inclure un contenu dans votre modèle de liste, vous aurez un regroupement des variables de page et de liste.

### Variables pour le modèle de page de tag

Identiques à celles du modèle de liste.

[⬅️ emojis](/fr/content/emojis.html) || [site multi-langues ➡️](/fr/content/multilingual.html)