---
title: Usage
date: 2019-05-26
description: How to run beulogue
weight: 1.2
---

Add `beulogue` to your `PATH` and run `beulogue` !

Here are the possible commands:

- `beulogue` or `beulogue build` to build the site. It uses the current working directory, use `-w ./path` to work somewhere else.
- `beulogue init <name>` to generate a very basic site (in the `<name>` folder, or current directory).
- `beulogue help` to show the help.
- `beulogue version` to show the the version.

Possible flags:

- `-dev` or `--development`: 
  - will use an empty `base` instead of the one given in the configuration file to make local navigation easier
  - will add markdown in the `drafts/` folder
- `-w ./path` or `--working-directory=./path` to set the working directory
- `-d` or `--debug`: show some logs
- `-h` or `--help`: show help

## :whale: With docker

To build a website with [Fish](https://fishshell.com/):

```shell
docker run --rm -it -v {$PWD}:/workspace -w /workspace siegfriedehret/beulogue build
```

Or with bash:

```shell
docker run --rm -it -v S{PWD}:/workspace -w /workspace siegfriedehret/beulogue build
```

## Templates

Protip: some basic templates just for you ! Please go to:

- [github](https://github.com/SiegfriedEhret/beulogue-templates/)
- [sourcehut](https://git.sr.ht/~siegfriedehret/beulogue-templates)
- (outdated) [bitbucket](https://bitbucket.org/siegfriedehret/beulogue-templates/)
- (outdated) [codeberg](https://codeberg.org/SiegfriedEhret/beulogue-templates/)

[⬅️ install](/en/usage/install.html) || [structure ➡️](/en/usage/structure.html)