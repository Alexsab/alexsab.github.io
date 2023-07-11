if [ "fff10e3e2104a741168da6ec3c90b423e08fa767" == "0000000000000000000000000000000000000000" ]; then
  git fetch origin master
  git checkout master
  COMMITS=$(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" master..f002985dd1253cef0c8dd98806116eda8a0ca1f2)
  echo "before=f002985dd1253cef0c8dd98806116eda8a0ca1f2"
else
  COMMITS=$(git log --pretty=format:"'<code>%h</code>' - %an, %ar : %s" fff10e3e2104a741168da6ec3c90b423e08fa767..f002985dd1253cef0c8dd98806116eda8a0ca1f2)
  echo "before=fff10e3e2104a741168da6ec3c90b423e08fa767..f002985dd1253cef0c8dd98806116eda8a0ca1f2"
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
