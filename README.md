# `beulogue`

> `beulogue` [\bøloɡ\]: french for blog.

# Installation

## Download binaries

- Linux: :white_check_mark:
- MacOS: :construction: (MacOS versions will always come later than the Linux one)
- Windows: :x:

Go to the [release page](https://github.com/SiegfriedEhret/beulogue/releases) !

## Build from source

- Clone this repository.
- Install [Crystal](https://crystal-lang.org/) and [Shards](https://github.com/crystal-lang/shards).
- Run `make install` then `make`.
- The `beulogue` binary will be in the `bin/` folder.

# Usage

Add `beulogue` to your path and run `beulogue` !

Here are the possible commands:

- `beulogue` or `beulogue build` to build the site.
- `beulogue help` to show the help.
- `beulogue version` to the the version. Amazing !

Protip: some basic templates just for you ! Please go to:

- [bitbucket](https://bitbucket.org/siegfriedehret/beulogue-templates/)
- [codeberg](https://codeberg.org/SiegfriedEhret/beulogue-templates/)
- [github](https://github.com/SiegfriedEhret/beulogue-templates/)

## Structure

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
└── templates
    ├── list.html
    └── page.html
```

- `beulogue.yml` is a mandatory configuration file.
- `content/` is the folder with all your pages.
- `templates/` is the folder for your templates.

## Configuration

The configuration file for your site must be `beulogue.yml`.

Example:

```yaml
base: https://ehret.me
title: My site
languages:
- en
- fr
```

The mandatory possible keys and values are:

- **base** (string): the base url of your website.
- **title** (string): the title of your website.
- **languages** (array of strings): the list of languages for the website. You must add at least one language; the first one is the default one.

The optional ones are:

- **rssFilename** (string): the name for the rss feed (default: `feed.xml`)/
- **sortPagesBy** (string): `date` or `weight`, set the property to sort the pages (default: `date`).
- **sortPagesOrder** (string): `asc` or `desc`, set the sorting order (default: `desc`).

## Content

Content items must be in the `content` folder of your site. The expected format is markdown.

The output files will have the same name as your markdown file (ending with `.html` instead of `.md`, of course).

You can inject content in your list template using a `_index.md` (for your content language) or `_index.LANG.md` for a given `LANG` (example: `_index.fr.md` for french).

### Front-matter

You can use front-matter, like that:

```
---
title: My title
date: 2019-05-07
description: A small description
tags:
- news
orphan: false
weight: 1.0
---

# My content...
```

The following properties are all mandatory:

- **title** (string): the title for your content item.
- **date** (string): a point in time, used to sort your content items ([more info on the format](https://yaml.org/type/timestamp.html)).
- **description** (string): a small description, used for the rss feed for example.

The following properties are optional:

- **orphan** (`true` or `false`): set to `true` and your page will be rendered but not included in the list templates.
- **tags** (array of string): some tags for your content.
- **weight** (float number): weight of the page, used for sorting. Default is `1.0`.

### Shortcodes

Shortcodes are small things that you can use in your contents.

#### Internal contents

- **Reference**: use `{{>ref path/to/content.md}}` to generate a link to this content.
	- :warning: if you reference a link to the current content, beulogue will crash.
	- beulogue will give you a warning if you reference a non existing content.

#### External contents

- **Dailymotion**: use `{{>dailymotion 12345}}` to embed a [Dailymotion](https://www.dailymotion.com/) video.
- **GitHub Gist**: use `{{>gist beulogue 123456}}` to embed a [Gist](https://help.github.com/en/articles/about-gists).
- **Vimeo**: use `{{>vimeo 12345}}` to embed a [Vimeo](https://www.vimeo.com/) video.
- **YouTube**: use `{{>youtube 12345}}` to embed a [YouTube](https://www.youtube.com/) video.

### Emoji

You can you emojis easily using `:smile:`, which renders as: :smile: !

The full list is [here](https://github.com/veelenga/emoji.cr/blob/master/src/emoji/emoji_map.cr).

## Templating

You have 2 html files to provide, they must be in the `templates` folder of your site:

- `list.html`: for the list of items
- `page.html`: for a content item

The templating engine is [mustache](https://mustache.github.io/).

### Mustache 101

If you have a variable `title`, use `{{title}}` in your template to display if.

> All variables are HTML escaped by default. If you want to return unescaped HTML, use the triple mustache: {{{name}}}.

If you have a variable `pages` which is a list of objects with a `title` property, you can loop using:

```
{{#pages}}
  <p>{{title}}</p>
{{/pages}}
```

If you want a conditional rendering for `title` whether it has or not a value, use:

```
{{#title}}
  Title is displayed ! {{title}}
{{/title}}
```

Go to the [mustache help](https://mustache.github.io/mustache.5.html) for more info.

### Variables for the page template

- `title`: the title of the page, from your content front matter.
- `date`: the date of your content, from its front matter
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

Note for `multilang`, you can use:

### Variables for the list template

- `pages`: a list with page elements. See previous section for details, `content` is not present though.
- `language`: the language of the page.
- `site`
	- `title`: the title of the site.
	- `languages`: a list of available languages for the site.
- `beulogue`
	- `cwd`: the current working directory.

If you use the `_index.md` or `_index.LANG.md` feature to include content in your list template, you'll get a merge of the page and list variables.

## Multilingual site

As explained in the Configuration part, you need at least one language, useful for the `lang` attribute for example.

If our configuration is like the following:

```yaml
base: https://ehret.me
title: My site
languages:
- en
- fr
```

Your contents:

- In *english*: filenames will be like `about.md` (no mention about the language in the filename).
- In *other language*: filenames will be like `about.fr.md` if you have a `fr` language.
- Filenames ending with a non defined language will given the default language.

Structure:

- If you have one language: everything will start the root of the `public` folder. A `feed.xml` file will be created in that folder.
- If you have multiple languages: each language will start in the `public/<language>/` folder. A default `index.html` file will be at the root of the `public` folder, redirecting to the default language. A  `feed.xml` file will be created for each language.

# Notes

`beulogue` is an experiment to discover the [Crystal](https://crystal-lang.org/) programming language, 2 years after playing with [the same concept with Node.js](https://www.npmjs.com/package/beulogue).

`beulogue` aims to stay simple and provide the following for the first version:

- [x] mardown files to html pages
- [x] basic templating (pages)
- [x] basic templating (list)
- [x] markdown front-matter
- [x] multilingual site
- [x] rss
- [x] cli, help & debug

And maybe at some point:

- [x] tags (in front matter)
- [x] shortcodes
- [x] links between languages
- [x] orphan pages
- [ ] tags (pages)
- [ ] drafts

And probably won't:

- [ ] pagination

And absolutely won't:

- [ ] livereload


# Development

## License

Licensed under the [GPLv3 license](./LICENSE).

## Versioning

`beulogue` follows my own FibVer (Fibonacci Versioning):

- Basically, it follows Semantic Versioning.
- You have to use Fibonacci suite numbers when you bump the version.
- Until you bump a major version, don't reset patch. For a version, it gives an idea of how many features and bugfixes you made.

I'll spec that one day...

## Contributing

Check the [contributing](./CONTRIBUTING.md) document for some info.

1. Fork it (https://github.com/SiegfriedEhret/beulogue/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Siegfried Ehret](https://github.com/SiegfriedEhret) - creator and maintainer
