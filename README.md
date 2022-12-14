
# Installation
Clone the repo to a directory of your choice, for example ~/andrea/code/

Then source it in your bash profile

```
source ~/andrea/code/git-shortcuts/git-shortcuts.bash
```

# Shortcuts Overview
Most of the time when I'm using git I find I use short-lived feature branches and a single head, master. In order to help make some of the most repetitive functions go a little faster, I created some shortcuts in my `.bash_profile`. 

The three most helpful are

1. `gurb`: If you work in a team and want to make sure you have the latest changes from master you can simply run this command. You can run it on your feature branch and it will checkout master, pull the latest changes for master, checkout your feature branch again, and rebase on the updated local master branch. This allows you to grab the latest changes and never have to worry about switching branches.
2. `gitready <commit_message>`: Will stage all your changes and commit them with a message
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

# Scripts Overview
!This is currently a work in progress! 
Many times I find it that you can get stuck in a rabbit hole of code changes and refactoring way too easily. It would be great if there was a way to bring visibility to this so that as developers we could get better at writing chunks of code with small, targeted changes. I think git can help with this!

## `loop_diff`
A simple script that will output the number of files changed every minute. You can leave it open while you code and use it as reminder to make incremental changes that touch as little files as possible. Don't go refactoring something somewhere else until you've finished the task you've set off to do! 
### Configuration
You can configure how often the script prints a new diff 
```
export LOOP_STATUS_INTERVAL=60
```

### Example Output
The script shows me that I've changed two classes so far
```
$ loop_diff
.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
M       home/src/main/java/com/peloton/analytics/AnalyticsHelper.java
M       home/src/test/java/com/peloton/analytics/AnalyticsHelperTest.java
.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
M       home/src/main/java/com/peloton/analytics/AnalyticsHelper.java
M       home/src/test/java/com/peloton/analytics/AnalyticsHelperTest.java
```

# Todo 
- Make main working branch configurable for those who branch from `develop` or a staging branch. 
- Use the `--force-with-lease` flag with git force push
- Add ability to push PRs to github from the command line with a subject and message
- Add ability to assign reviewers and assignees to PRs from the command line
