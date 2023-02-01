#!/bin/sh

TICKET=$(~/code/github/dotfiles/streaming/commit/commit)
test -n $TICKET && gum confirm "Couldnt find ticket do you want to add it manually?" && TICKET=$(gum input --placeholder "ticket")

TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert" "program" "ci" "k8s")
SCOPE=$(gum input --placeholder "scope")

# Since the scope is optional, wrap it in parentheses if it has a value.
test -n "$SCOPE" && SCOPE="($SCOPE)"
test -n "$TICKET" && SCOPE="$TICKET "

# Pre-populate the input with the type(scope): so that the user may change it
SUMMARY=$(gum input --value "$TICKET$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change (CTRL+D to finish)")

echo $SUMMARY $DESCRIPTION

# Commit these changes
gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
