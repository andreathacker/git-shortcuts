#!/bin/bash

export CURRENT_BRANCH_NAME=""
export CURRENT_JURA_TAG=""

# git - status
# Git status
gs() {
  git status
} 

# git - branch
# Git branch
gb() {
  git branch
}

# git - update rebase branch
# On the current branch, checkout out master and pull the latest changes. Then switch back to your branch and rebase on master. 
gurb() {
  get_current_branch_name
  echo $CURRENT_BRANCH_NAME

  git checkout master
  git pull
  
  git checkout $CURRENT_BRANCH_NAME
  git rebase master
}

# git - commit
# Commit current changes with a message
gc() {
  get_current_branch_name
  git commit -m "$1"
}

#git - tagged commit
# Commit with a JIRA tag pulled from the branch name
gtc() {
  get_jira_tag
  gc "$JIRA_TAG: $1"
} 

# git - force push
# Force push commits
gfp() {
  git push --force
}

# git - add all
# Add all staged files
ga() {
  git add -A
}

# git - open pull request
gopr() {
  git pull-request -F ~/pr-message.md | pbcopy
}

# Add all changes and commit with message
gitready() {
  ga
  gtc "$1"
}

# Push branch to origin (just in case it already isn't linked with your local branch
# Pull the latest changes from master and rebase your branch against master
# Force push your branch to the origin
gitrdone() {
  get_current_branch_name
  git push --set-upstream origin $CURRENT_BRANCH_NAME
  gurb
  gfp
}

get_current_branch_name() {
  # Get current branch name
  branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
  branch_name="(unnamed branch)"     # detached HEAD
  branch_name=${branch_name##refs/heads/}
  CURRENT_BRANCH_NAME=$branch_name
  echo $CURRENT_BRANCH_NAME
}

get_jira_tag() {
  get_current_branch_name
  JIRA_TAG=$( echo $CURRENT_BRANCH_NAME | cut -d_ -f1 )
  echo $JIRA_TAG
}
