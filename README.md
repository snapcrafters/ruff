[![ruff](https://snapcraft.io/ruff/badge.svg)](https://snapcraft.io/ruff)
[![ruff](https://snapcraft.io/ruff/trending.svg?name=0)](https://snapcraft.io/ruff)
[![Release](https://github.com/lengau/ruff-snap/actions/workflows/release-to-candidate.yaml/badge.svg)](https://github.com/lengau/ruff-snap/actions/workflows/release-to-candidate.yaml)

# ruff-snap

A [snap](https://snapcraft.io/about) package for [Ruff](https://github.com/astral-sh/ruff).

NOTE: The core24 branch contains a testing version of this snap using the prerelease
core24 ubuntu base. Use with caution.
The edge branch gets the latest snapshot of ruff and builds it. Good luck!

## Installing

[![Get it from the Snap Store](https://snapcraft.io/static/images/badges/en/snap-store-black.svg)](https://snapcraft.io/ruff)

    sudo snap install ruff 
    
To install the core24 branch, you can run:

    sudo snap install --channel=latest/edge ruff 

## Build

To build this for yourself, simply clone the repository and run `snapcraft pack`.

The snap package is built on the [launchpad project](https://launchpad.net/ruff-snap).
View the [snap packages here](https://launchpad.net/ruff-snap/+snaps).
