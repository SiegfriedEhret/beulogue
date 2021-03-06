---
title: Utilisation
date: 2019-10-14
description: Utilisation de beulogue
weight: 1.2
---

Ajoutez `beulogue` à votre `PATH` puis lancez `beulogue` !

Les commandes disponibles sont:

- `beulogue` ou `beulogue build` pour construire le site. Ça utilise le répertoire courant, utilisez `-w ./path` pour travailler dans un autre répertoire.
- `beulogue init <name>` pour créer une base de site (dans le répertoire `<name>`, ou le répertoire courant).
- `beulogue help` pour afficher l'aide.
- `beulogue version` pour afficher la version.

Drapeaux:

- `-dev` or `--development`: 
  - pour utiliser une `base` vide au lieu de celle indiquée dans le fichier de configuration pour rendre la navigation plus facile en local
  - pour prendre en compte les fichiers dans le répertoire `drafts/`
- `-w ./path` ou `--working-directory=./path` pour choisir le répertoire de travail
- `-d` or `--debug`: pour afficher quelques messages
- `-h` or `--help`: pour afficher l'aide

## :whale: Avec docker

Pour construire un site sous [Fish](https://fishshell.com/):

```shell
docker run --rm -it -v {$PWD}:/workspace -w /workspace siegfriedehret/beulogue build
```

Ou sous bash:

```shell
docker run --rm -it -v S{PWD}:/workspace -w /workspace siegfriedehret/beulogue build
```

## Kits de démarrage

Protip: voici quelques kits de démarrage juste pour vous ! Rendez-vous sur l'un de ces miroirs:

- [github](https://github.com/SiegfriedEhret/beulogue-templates/)
- [sourcehut](https://git.sr.ht/~siegfriedehret/beulogue-templates)
- (pas à jour) [bitbucket](https://bitbucket.org/siegfriedehret/beulogue-templates/)
- (pas à jour) [codeberg](https://codeberg.org/SiegfriedEhret/beulogue-templates/)

[⬅️ installation](/fr/usage/install.html) || [structure ➡️](/fr/usage/structure.html)