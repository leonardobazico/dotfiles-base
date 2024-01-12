# dotfiles-base

This repo contains installation steps and common application settings.

To install the minimal bundle use: `make install-min`

`make help` for more details.

## [Homebrew](https://brew.sh)

- Install all homebrew dependencies or update the installed ones
  - `make install-homebrew-dependencies`
- Get the current list of installed dependencies into the brew file
  - `make dump-homebrew-dependencies`

## [asdf](https://asdf-vm.com)

- Install all asdf dependencies or update the installed ones
  - `make install-asdf-dependencies`
- To solve some issue with different installed versions of a cli, use the `asdf reshim` command.
  - For example, the curreng golang version is `1.21.3` but the installed packages binaries are pointing to the `1.19` version. So running `asdf reshim golang` will update the binaries to the current version.
