tailf() {
		((!$#)) && echo "No file provided to follow!" && return 1

		tail -f "$1"  |  bat --paging=never --style=numbers -l log
}

# Description:
#   This function automates the cleanup of local Git branches that no longer
#   have an upstream branch. Useful for keeping your local repository clean
#   after remote branches have been deleted.
gh_prune_branch() {
	git fetch -p
    for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do
        git branch -D "$branch"
    done
}