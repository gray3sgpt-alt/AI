#!/bin/bash

# Backup script for ~/Downloads/AI project to Git repository
# This script will add all changes, commit them, and push to the remote repository

set -e  # Exit immediately if a command exits with a non-zero status

echo "Starting backup of ~/Downloads/AI to Git repository..."

# Change to the project directory
cd "$HOME/Downloads/AI" || { echo "Error: Could not change to ~/Downloads/AI directory"; exit 1; }

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "Error: Not in a git repository. Please initialize git first."
    exit 1
fi

# Determine the default branch name (master or main)
DEFAULT_BRANCH=$(git symbolic-ref --short HEAD 2>/dev/null || echo "master")

# Configure git to handle pull properly to avoid divergent branches error
git config pull.rebase false

# Pull latest changes from remote to avoid conflicts
echo "Pulling latest changes from remote repository..."
git pull origin "$DEFAULT_BRANCH" --no-edit

# Add all changes (including untracked files)
echo "Adding all changes to git..."
git add .

# Check if there are any changes to commit
if git diff --cached --quiet; then
    echo "No changes to commit. Repository is up to date."
else
    # Create a commit with timestamp
    COMMIT_MESSAGE="Auto-backup: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "Creating commit with message: $COMMIT_MESSAGE"
    git commit -m "$COMMIT_MESSAGE"

    # Push changes to remote repository using the correct branch name
    echo "Pushing changes to remote repository..."
    git push origin "$DEFAULT_BRANCH"

    echo "Backup completed successfully!"
fi

echo "Script finished."