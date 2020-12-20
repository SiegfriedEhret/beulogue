---
title: Installation
date: 2019-10-14
description: Comment installer beulogue
weight: 1.1
---

## Télécharger les binaires

- Linux: :white_check_mark:
- MacOS: :construction: (les versions MacOS arriveront toujours en décalé)
- Windows: :x:

Allez à la page des [livraisons](https://github.com/SiegfriedEhret/beulogue/releases) !

## :whale: Utiliser l'image Docker

`beulogue` est disponible sous la forme d'une [image Docker](https://hub.docker.com/r/siegfriedehret/beulogue).

Pour le lancer (`help` est la commande par défaut):

```shell
docker run --rm -it siegfriedehret/beulogue
```

## Construire depuis les sources

- Clonez ce dépôt.
- Installez [Crystal](https://crystal-lang.org/) et [Shards](https://github.com/crystal-lang/shards).
- Lancez `make install` puis `make`.
- Le binaire `beulogue` sera dans le répertoire `bin/`.

[⬅️ accueil](/fr/) || [utilisation ➡️](/fr/usage/usage.html)