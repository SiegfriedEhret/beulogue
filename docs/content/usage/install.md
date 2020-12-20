---
title: Installation
date: 2019-05-26
description: How to install beulogue
weight: 1.1
---

## Download binaries

- Linux: :white_check_mark:
- MacOS: :white_check_mark:
- Windows: :x:

Go to the [release page](https://github.com/SiegfriedEhret/beulogue/releases) !

## :whale: Use the Docker image

`beulogue` is available as a [Docker image](https://hub.docker.com/r/siegfriedehret/beulogue).

Run it (`help` is the default command):

```shell
docker run --rm -it siegfriedehret/beulogue
```

## Build from source

- Clone this repository.
- Install [Crystal](https://crystal-lang.org/) and [Shards](https://github.com/crystal-lang/shards).
- Run `make install` then `make`.
- The `beulogue` binary will be in the `bin/` folder.

[⬅️ home](/en/) || [usage ➡️](/en/usage/usage.html)