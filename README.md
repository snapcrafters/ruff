[![ruff](https://snapcraft.io/ruff/badge.svg)](https://snapcraft.io/ruff)
[![ruff](https://snapcraft.io/ruff/trending.svg?name=0)](https://snapcraft.io/ruff)
[![Release](https://github.com/snapcrafters/ruff/actions/workflows/release-to-candidate.yaml/badge.svg)](https://github.com/snapcrafters/ruff/actions/workflows/release-to-candidate.yaml)

# ruff-snap

A [snap](https://snapcraft.io/about) package for [Ruff](https://github.com/astral-sh/ruff).

## Installing

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/ruff)

    sudo snap install ruff 

## Build

To build this for yourself, simply clone the repository and run `snapcraft pack`.

The snap package is built on the [launchpad project](https://launchpad.net/ruff-snap).
View the [snap packages here](https://launchpad.net/ruff-snap/+snaps).

## Usage

Once installed, you can use ruff from the command line as usual. You can also use the ruff language server as `ruff.lsp`. If you'd rather use the language server with `ruff-lsp` (its default command), you can alias it using `snap alias ruff.lsp ruff-lsp`.
