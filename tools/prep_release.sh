#!/usr/bin/env bash
# Prepare the repository for the changes coming from an upstream release.

set -eu -o pipefail

upstream_release=$1

echo "Preparing upstream release ${upstream_release}"

echo "Setting snap version to ${upstream_release}"
sed -i 's/^\(version: \).*$/\1'"${upstream_release}"'/' snap/snapcraft.yaml

echo "Setting tags to ${upstream_release}"
sed -i 's/^\( *source-tag: \).*$/\1'"${upstream_release}/" snap/snapcraft.yaml
