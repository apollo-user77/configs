#!/bin/sh

# Git status plugin for CliFM
# Written by L. Abramovich

# Description: Check if the current directory is inside a git work
# tree, and, if true, print status, i.e., branch name and non
# commited/tracked files

# NOTE: This script is not intended to be used as a normal plugin,
# that is, called via an action name, but rather to be executed as
# a prompt command (see the configuration file)

# Some useful git commands for a more complex output:

#am I inside git repo? [ "$(git rev-parse --is-inside-work-tree)" = "true" ] && echo "Yes"
#current remote/repo: git rev-parse --abbrev-ref @{upstream}
#current repo: git describe --contains --all HEAD
#total upstream commits: git rev-list --count @{upstream}
#last local commit short hash: git rev-parse --short HEAD
#last upstream commit short hash: git rev-parse --short @{upstream}
#Is something stashed: git rev-parse --verify --quiet refs/stash
#Non-commited/tracked local changes: git status | grep -q "nothing to commit" && echo "No" || echo "Yes" or git status -sb

[ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" != "true" ] && exit 1

git status -sb 2>/dev/null

exit 0
