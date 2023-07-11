if [ "68d5e43fc27fbb3e96d167312ca0ac01be6dfe83" == "0000000000000000000000000000000000000000" ]; then
  git fetch origin master
  git checkout master
  COMMITS=$(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" 244842f01f2de06e5cbf1814a79c0763f1b380d6..origin)
else
  COMMITS=$(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" 68d5e43..b839b95)
fi

# Convert the list of commits to an array
IFS=$'\n' read -rd '' -a COMMITS_ARRAY <<< "$COMMITS"

# Process each commit
echo "full_list<<EOF"
for COMMIT in "${COMMITS_ARRAY[@]}"; do
  echo "$COMMIT"
done
echo "EOF"

LINES_COUNT=${#COMMITS_ARRAY[*]}
if [ "$LINES_COUNT" == "1" ]; then
  echo "lines_count=$LINES_COUNT new commit"
else
  echo "lines_count=$LINES_COUNT new commits"
fi
