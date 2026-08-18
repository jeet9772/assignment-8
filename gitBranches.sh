#!/bin/bash
#
# gitBranches.sh - simple branch management script
#
# Usage:
#   ./gitBranches.sh -l                                # list branches
#   ./gitBranches.sh -b <branch_name>                   # create branch
#   ./gitBranches.sh -d <branch_name>                   # delete branch
#   ./gitBranches.sh -m -1 <branch1> -2 <branch2>        # merge branch1 into branch2
#   ./gitBranches.sh -r -1 <branch1> -2 <branch2>        # rebase branch1 onto branch2
#

usage() {
    echo "Usage:"
    echo "  $0 -l"
    echo "  $0 -b <branch_name>"
    echo "  $0 -d <branch_name>"
    echo "  $0 -m -1 <branch1> -2 <branch2>   (merge branch1 into branch2)"
    echo "  $0 -r -1 <branch1> -2 <branch2>   (rebase branch1 onto branch2)"
    exit 1
}

[ $# -eq 0 ] && usage

action="$1"
shift

case "$action" in
    -l)
        git branch
        ;;

    -b)
        branch_name="$1"
        [ -z "$branch_name" ] && usage
        git branch "$branch_name"
        ;;

    -d)
        branch_name="$1"
        [ -z "$branch_name" ] && usage
        git branch -d "$branch_name"
        ;;

    -m)
        if [ "$1" != "-1" ] || [ "$3" != "-2" ]; then
            usage
        fi
        branch1="$2"
        branch2="$4"
        [ -z "$branch1" ] || [ -z "$branch2" ] && usage

        echo "Merging '$branch1' into '$branch2'..."
        git checkout "$branch2" && git merge "$branch1"
        ;;

    -r)
        if [ "$1" != "-1" ] || [ "$3" != "-2" ]; then
            usage
        fi
        branch1="$2"
        branch2="$4"
        [ -z "$branch1" ] || [ -z "$branch2" ] && usage

        echo "Rebasing '$branch1' onto '$branch2'..."
        git checkout "$branch1" && git rebase "$branch2"
        ;;

    *)
        usage
        ;;
esac
