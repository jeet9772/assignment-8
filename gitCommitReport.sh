#!/bin/bash
#
# gitCommitReport.sh - generate a commit report for a repo over the last N days
#
# Usage:
#   ./gitCommitReport.sh -u <repo_url> -d <days>

usage() {
    echo "Usage: $0 -u <repo_url> -d <days>"
    exit 1
}

while getopts "u:d:" opt; do
    case "$opt" in
        u) REPO_URL="$OPTARG" ;;
        d) DAYS="$OPTARG" ;;
        *) usage ;;
    esac
done

[ -z "$REPO_URL" ] || [ -z "$DAYS" ] && usage

WORK_DIR=$(mktemp -d)
REPORT_FILE="commit_report.csv"

echo "Cloning $REPO_URL ..."
git clone --quiet "$REPO_URL" "$WORK_DIR" || { echo "Clone failed"; exit 1; }

cd "$WORK_DIR" || exit 1

echo "CommitID,AuthorName,AuthorEmail,Date,CommitMessage,ChangedFiles,IsValid" > "$OLDPWD/$REPORT_FILE"

JIRA_PATTERN="^JIRA-[0-9]+:"

COMMITS=$(git log --since="$DAYS days ago" --pretty=format:"%H")

for commit in $COMMITS; do
    author_name=$(git log -1 --pretty=format:"%an" "$commit")
    author_email=$(git log -1 --pretty=format:"%ae" "$commit")
    date=$(git log -1 --pretty=format:"%ad" "$commit")
    message=$(git log -1 --pretty=format:"%s" "$commit")

    changed_files=$(git diff-tree --no-commit-id --name-only -r "$commit" | tr '\n' ';')

    if [[ "$message" =~ $JIRA_PATTERN ]]; then
        is_valid="yes"
    else
        is_valid="no"
    fi

    message_escaped=$(echo "$message" | sed 's/"/""/g')

    echo "\"$commit\",\"$author_name\",\"$author_email\",\"$date\",\"$message_escaped\",\"$changed_files\",\"$is_valid\"" >> "$OLDPWD/$REPORT_FILE"
done

cd "$OLDPWD" || exit 1
rm -rf "$WORK_DIR"

echo "Report generated: $REPORT_FILE"
