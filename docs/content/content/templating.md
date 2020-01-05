---
title: Templating
date: 2019-05-25
description: Templating with mustache
weight: 2.4
---

You have 2 html files to provide, they must be in the `templates` folder of your site:

- `list.html`: for the list of items
- `page.html`: for a content item

The templating engine is [mustache](https://mustache.github.io/).

### Mustache 101

{{=<% %>=}}

If you have a variable `title`, use `{{title}}` in your template to display it.

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

- `title`: the title of the content, from the front matter.
- `date`: the date of your content, from the front matter
- `dateFormatted`: the same thing formatted as `YYYY-MM-DD`.
- `content`: your content in html.
- `contentPath`: the path to your markdown, relative to the `content` folder.
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

### Variables for the list template

- `pages`: a list with page elements. See previous section for details, `content` is not present though.
- `language`: the language of the page.
- `site`
	- `title`: the title of the site.
	- `languages`: a list of available languages for the site.
- `beulogue`
	- `cwd`: the current working directory.

If you use the `_index.md` or `_index.LANG.md` feature to include content in your list template, you'll get a merge of the page and list variables.

### Variables for the tag templates

Same as the ones from the list template.

[⬅️ emojis](/en/content/emojis.html) || [multilingual ➡️](/en/content/multilingual.html)