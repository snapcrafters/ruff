#!/bin/bash
# Tests for the ruff snap.

repositories(){
    echo https://github.com/snapcore/snapcraft
    echo https://github.com/canonical/charmcraft
    echo https://github.com/canonical/rockcraft
    echo https://github.com/pytest-dev/pytest
    echo https://github.com/python/mypy
    echo https://github.com/jupyter-server/jupyter_server
}

test_repo(){
    local repo_dir=$(mktemp --directory ruff-test-XXXXXXXX)
    git clone --depth=1 $1 $repo_dir
    pushd $repo_dir
    local return_code=0
    ruff check --select=ALL
    return_code=$?
    ruff format
    rc2=$?
    if [[ $rc2 != "0" && $return_code == "0" ]]; then
        return_code=$rc2
    fi
    popd
    rm -rf $repo_dir
    return $return_code
}

ruff version || exit 1
ruff help || exit 1

any_failed=false
for repo in $(repositories); do
    echo "::group::${repo}"
    if test_repo "${repo}"; then
        echo "status=$repo: success" >> $1
        echo "::endgroup::"
        echo "Succeeded"
    else
        exit_code=$?
        any_failed=true
        echo "status=$repo: failed with exit code $exit_code" >> $1
        echo "::endgroup::"
        echo "Failed with exit code $exit_code"
    fi
done
if [[ $any_failed == "true" ]]; then
    exit 1
fi
