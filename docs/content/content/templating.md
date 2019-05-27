---
title: Templating
date: 2019-05-25
description: Templating with mustache
weight: 2.3
---

You have 2 html files to provide, they must be in the `templates` folder of your site:

- `list.html`: for the list of items
- `page.html`: for a content item

The templating engine is [mustache](https://mustache.github.io/).

### Mustache 101

{{=<% %>=}}

If you have a variable `title`, use `{{title}}` in your template to display if.

> All variables are HTML escaped by default. If you want to return unescaped HTML, use the triple mustache: {{{name}}}.

If you have a variable `pages` which is a list of objects with a `title` property, you can loop using:

```
{{#pages}}
  {{title}}
{{/pages}}
```

If you want a conditional rendering for `title` whether it has or not a value, use:

```
{{#title}}
  Title is displayed ! {{title}}
{{/title}}
```

Go to the [mustache help](https://mustache.github.io/mustache.5.html) for more info.

<%={{ }}=%>

### Variables for the page template

- `title`: the title of the page, from your content front matter.
- `date`: the date of your content, from its front matter
- `dateFormatted`: the same thing formatted as `YYYY-MM-DD`.
- `content`: your content in html.
- `language`: the language of your content.
- `multilang`: a list of objects with:
	- `language`: a language (like in your beulogue.yml).
	- `url`: the url for the matching language.
- `url`: the url of your page.
- `site`
	- `title`: the title of the site.
	- `languages`: a list of available languages for the site.
- `beulogue`
	- `cwd`: the current working directory.

Note for `multilang`, you can use:

### Variables for the list template

- `pages`: a list with page elements. See previous section for details, `content` is not present though.
- `language`: the language of the page.
- `site`
	- `title`: the title of the site.
	- `languages`: a list of available languages for the site.
- `beulogue`
	- `cwd`: the current working directory.

[⬅️ shortcodes](/en/content/shortcodes.html) || [multilingual ➡️](/en/content/multilingual.html)