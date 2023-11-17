# ruff-snap

A [snapcraft](https://snapcraft.io/about) package for [Ruff](https://github.com/charliermarsh/ruff). It also contains flake8-to-ruff.

NOTE: The core24 branch contains a testing version of this snap using the prerelease
core24 ubuntu base. Use with caution.
The edge branch gets the latest snapshot of ruff and builds it. Good luck!

## Installing

To install the core24 branch, you can run:

    sudo snap install --channel=latest/edge ruff 

## Build

To build this for yourself, simply clone the repository and run `snapcraft pack`.

The snap package is built on the [launchpad project](https://launchpad.net/ruff-snap).
View the [snap packages here](https://launchpad.net/ruff-snap/+snaps).
