---
title: Multilingual site
date: 2019-05-25
description: How to make a multilingual site
weight: 2.5
---

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

- In *english* (here, `en`, the first language of the list): filenames will be like `about.md` (no mention about the language in the filename).
- In *other language* (here, `fr`): filenames will be like `about.fr.md`.
- Filenames ending with a non defined language will given the default language; in our example, `en`.

Structure:

- If you have one language: everything will start the root of the `public` folder. A `feed.xml` file will be created in that folder.
- If you have multiple languages: each language will start in the `public/<language>/` folder. A default `index.html` file will be at the root of the `public` folder, redirecting to the default language. A `feed.xml` file will be created for each language.

[⬅️ templating](/en/content/templating.html) || [notes ➡️](/en/other/notes.html)
