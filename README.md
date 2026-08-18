# Assignment 8 – Git Branching, Merge, Rebase, Tags & Commit Report

Submitted by Jeetendra Singh

## Part A: Merge and Rebase (ninja branch)

Created ninja branch, added README.md, merged into master, modified README on both master and ninja to create a conflict, resolved using `--theirs` so ninja's changes win.

```bash
git merge-base master ninja
git show master:ninja/README.md
git show ninja:ninja/README.md
git log --oneline --graph --decorate --all -10
```
<img width="1280" height="800" alt="11" src="https://github.com/user-attachments/assets/d041a255-9c71-4878-8959-e6201d54a08b" />

## Part B: gitBranches.sh

Script to manage branches - list, create, delete, merge, rebase.

```bash
grep -E 'git branch|git checkout|git merge|git rebase' gitBranches.sh
git checkout master
git add gitBranches.sh
git status
git commit -m "Add git branch management script"
git status
git log --oneline --decorate -8
```
<img width="1280" height="800" alt="22" src="https://github.com/user-attachments/assets/f1090986-0941-4061-bae9-1a9c0e0f2c4c" />

## Part C: gitTags.sh

Script to manage tags - create, list, delete.

```bash
./gitTags.sh -l
./gitTags.sh -d ninja_1.0
./gitTags.sh -l
git status
git add gitTags.sh
git commit -m "Add git tag management script"
```
<img width="1280" height="800" alt="33" src="https://github.com/user-attachments/assets/25b5a6a0-338d-46dd-ad2b-8851beb1e45b" />

## Part D: gitCommitReport.sh

Script to generate commit report of a repo (input: repo url, days; output: commit id, author, email, message, changed files, csv format).

```bash
echo "git_commit_report.csv" >> .gitignore
git add gitCommitReport.sh .gitignore
git commit -m "Add git commit report script"
./gitCommitReport.sh
./gitCommitReport.sh -u https://github.com/opstree/spring3hibernate.git -d 40
wc -l git_commit_report.csv
```
<img width="1280" height="800" alt="44" src="https://github.com/user-attachments/assets/44ab90c0-4e35-457f-95db-1d25ce7b25da" />
