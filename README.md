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

Add `beulogue` to your `PATH` and run `beulogue` !

:memo: The documentation is available at https://beulogue.ehret.me/

Here are the possible commands:

- `beulogue` or `beulogue build` to build the site.
- `beulogue help` to show the help.
- `beulogue version` to show the the version.

Possible flags:

- `-dev` or `--development`: 
  - will use an empty `base` instead of the one given in the configuration file to make local navigation easier
  - will add markdown in the `drafts/` folder
- `-d` or `--debug`: show some logs
- `-h` or `--help`: show help

Protip: a few starter kits are available on these mirrors:

- [bitbucket](https://bitbucket.org/siegfriedehret/beulogue-templates/)
- [codeberg](https://codeberg.org/SiegfriedEhret/beulogue-templates/)
- [github](https://github.com/SiegfriedEhret/beulogue-templates/)

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
- [x] tags (pages)
- [x] drafts

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

Check the [CONTRIBUTING.md](./CONTRIBUTING.md) document for some info.

1. Fork it (https://github.com/SiegfriedEhret/beulogue/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Siegfried Ehret](https://github.com/SiegfriedEhret) - creator and maintainer
