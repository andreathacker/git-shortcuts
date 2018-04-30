## Overview
Most of the time when I'm using git I find I use short-lived feature branches and a single head, master. In order to help make some of the most repetitive functions go a little faster, I created some shortcuts in my `.bash_profile`. 

The three most helpful are

1. `gurb`: If you work in a team and want to make sure you have the latest changes from master you can simply run this command. You can run it on your feature branch and it will checkout master, pull the latest changes for master, checkout your feature branch again, and rebase on the updated local master branch. This allows you to grab the latest changes and never have to worry about switching branches 
2. `gfp`: A very simple git force push, but just shorter to type :)
3. `gitrdone`: Will push and track your branch to the origin if it hasn't already happened. Then it will use the `gurb` command to grab the latest changes, and finally run `gfp` to push your changes. 

So with one command `gitrdone` you can have the latest changes pushed to your feature branch. 

## Additional JIRA Shortcuts with Git 
Another tool I often use when working in teams is JIRA. A lot of teams like the built in Git tracking it enables on a commit basis. However, it can often be annoying to remember your ticket tag and type it into each commit :( 

I've created a couple functions to help with this workflow. 

1. `gtc`: If you follow the branch naming convention `<ticket-number>_<ticket-description>` the `gtc` command will automatically parse this from your active branch and prepend the ticket number to your commit message. 
2. `gitready`: Performs a `git add -A` and then a `gtc`. So you can use this to stage all your changes and commit them with a JIRA tag in one command. 

## Example Usage
```
$ gitready "Add the greatest, newest feature"
$ gitrdone
```

## Warnings
This may not follow the git conventions that your team uses. In particular, be warned that these functions are using `git rebase` and `git push --force` which can cause very terrible things to happen if you have multiple developers working on the same branch. Feel free to modify the usage of this script to replace these with alternatives like `git merge` and `git push` if that fits your workflow better. 

## Installation
Clone the repo to a directory of your choice, for example ~/david/code/

Then source it in your bash profile

```
source ~/david/code/git-shortcuts/git-shortcuts.bash
export GIT_SHORTCUTS_REPO="https://github.com/ethereum/go-ethereum"
export GIT_SHORTCUTS_BRANCH="master"
```
The `GIT_SHORTCUTS_REPO` and `GIT_SHORTCUTS_BRANCH` values can be used which repository to use, and what branch should be treated as your main branch that you want to scripts to rebase/merge changes from.  

## Todo 
- Make main working branch configurable for those who branch from `develop` or a staging branch. 
- Use the `--force-with-lease` flag with git force push
- Add ability to push PRs to github from the command line with a subject and message
- Add ability to assign reviewers and assignees to PRs from the command line
