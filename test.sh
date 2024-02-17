#!/bin/bash
# Tests for the ruff snap.

set -e

cleanup(){
    rm -rf ruff-snap-test-*
}
trap cleanup EXIT

summary_file="${GITHUB_STEP_SUMMARY:-/dev/stderr}"
echo -e '## Summary:\n' > "$summary_file"

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
    check_result="Success"
    if ruff check --exit-zero --select=ALL --preview --fix --unsafe-fixes "${repo_dir}" ; then
        echo "- ${repo}: check success" >> $summary_file
    else
        exit_code=$?
        any_failed=true
        check_result="Failed"
        echo "- ${repo}: Failed with exit code $exit_code" >> $summary_file
    fi
    if ruff format --preview "${repo_dir}" ; then
        echo "- ${repo}: format success" >> $summary_file
    else
        exit_code=$?
        any_failed=true
        check_result="Failed"
        echo "- ${repo}: Failed with exit code $exit_code" >> $summary_file
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

any_failed=false
for repo in $(repositories); do
    test_repo "${repo}"
done
if [[ $any_failed == "true" ]]; then
    echo "Overall: Failed"
    exit 1
fi
echo "Overall: Succeeded"
