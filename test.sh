#!/bin/bash
# Tests for the ruff snap.

set -e

cleanup(){
    rm -rf ruff-snap-test-*
}
trap cleanup EXIT

summary_file="${GITHUB_STEP_SUMMARY:-/dev/stderr}"

repositories(){
    echo https://github.com/canonical/snapcraft
    echo https://github.com/canonical/charmcraft
    echo https://github.com/canonical/rockcraft
    echo https://github.com/jupyter-server/jupyter_server
    echo https://github.com/pydantic/pydantic
    echo https://github.com/pypa/pip
    echo https://github.com/pytest-dev/pytest
    echo https://github.com/python/mypy
    echo https://github.com/tiangolo/fastapi
}

test_repo(){
    echo "::group::Repository: ${repo}"
    local repo_dir=$(mktemp --directory ruff-snap-test-XXXXXXXX)
    git clone --depth=1 $1 $repo_dir
    echo -n "| ${repo} | $(cd $repo_dir; git rev-parse --short HEAD) | " >> $summary_file
    if (cd "${repo_dir}"; ruff check); then
        echo -n "✅ | " >> $summary_file
    else
        echo -n "❌ | " >> $summary_file
    fi
    if (cd "${repo_dir}"; ruff check --preview --fix --unsafe-fixes); then
        echo -n "✅ | " >> $summary_file
    else
        echo -n "❌ | " >> $summary_file
    fi
    if (cd "${repo_dir}"; ruff format); then
        echo -n "✅ | " >> $summary_file
    else
        echo -n "❌ | " >> $summary_file
    fi
    if (cd "${repo_dir}"; ruff format --preview); then
        echo "✅ | " >> $summary_file
    else
        echo "❌ | " >> $summary_file
    fi

    echo "::endgroup::"
    echo "$check_result"
}

echo -n "ruff version: " >> $summary_file
ruff version | tee -a $summary_file
echo "::endgroup::"
echo "::group::Help"
ruff help
echo "::endgroup::"
echo "::group::Rules:"
ruff rule --all
echo "::endgroup::"

echo "| Repository | Commit | Standard check | Check + preview + fix | Format | Format + preview |" >> $summary_file
echo "|------------|--------|----------------|-----------------------|--------|------------------|" >> $summary_file
for repo in $(repositories); do
    test_repo "${repo}"
done
