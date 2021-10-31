echo "Moving to $1 and pull, and rebasing"
git checkout $1;
git pull;
git checkout -;
git rebase $1;
echo "Rebase complete."
# echo "Removing node_modules and installing them again"
# rm -rf node_modules;
# yarn install;
# echo "Build the ts libraries"
# yarn build:ts;
