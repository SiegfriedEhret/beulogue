---
title: Content
date: 2019-05-25
description: All about contents in beulogue
weight: 2.0
---

## Where

Content items must be in the `content` folder of your site. 

## What

The expected format is [markdown (`.md`)](https://en.wikipedia.org/wiki/Markdown), or [gemini (`.gmi`)](https://gemini.circumlunar.space/docs/specification.html) (see part 5).

## Output

The output files will have the same name as your markdown file. The filenames end with `.html` instead of `.md` or `.gmi`, of course.

## Extra

You can inject content in your list template using a `_index.md` (for your content language) or `_index.LANG.md` for a given `LANG` (example: `_index.fr.md` for French). Same if you prefer `.gmi` file!

[⬅️ configuration](/en/usage/configuration.html) || [front matter ➡️](/en/content/front-matter.html)