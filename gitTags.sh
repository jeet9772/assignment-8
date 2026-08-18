#!/bin/bash

usage() {
    echo "Usage:"
    echo "  $0 -t <tag_name>   (create tag)"
    echo "  $0 -l              (list tags)"
    echo "  $0 -d <tag_name>   (delete tag)"
    exit 1
}

[ $# -eq 0 ] && usage

action="$1"
shift

case "$action" in
    -t)
        tag_name="$1"
        [ -z "$tag_name" ] && usage
        git tag "$tag_name"
        ;;

    -l)
        git tag
        ;;

    -d)
        tag_name="$1"
        [ -z "$tag_name" ] && usage
        git tag -d "$tag_name"
        ;;

    *)
        usage
        ;;
esac
