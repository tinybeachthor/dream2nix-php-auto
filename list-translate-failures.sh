#/bin/sh

IDS=$(jq -ercM '.[].id' libraries-io/index.json)
IGNORES=$(cat ignore-packages)

INPUT_COUNT=$(echo $IDS | wc --words)

SKIP_COUNT=0
SUCCESS_COUNT=0
for ID in $IDS
do
  # should ignore?
  DO_SKIP=0
  for IGNORE in $IGNORES
  do
    if [[ $ID == $IGNORE* ]]
    then
      DO_SKIP=1
      SKIP_COUNT=$((SKIP_COUNT+1))
      continue
    fi
  done
  if [[ $DO_SKIP == 1 ]]
  then
    continue
  fi

  # check
  if [ -e "libraries-io/locks/$ID" ]
  then
    SUCCESS_COUNT=$((SUCCESS_COUNT+1))
  else
    echo "Missing: $ID"
    FAIL_COUNT=$((FAIL_COUNT+1))
  fi
done

cat <<EOF

IN: $INPUT_COUNT  \
SKIP: $SKIP_COUNT  \
SUCCESS: $SUCCESS_COUNT  \
FAIL: $FAIL_COUNT

SUCCESS RATE: ~$(((SUCCESS_COUNT * 100) / (SUCCESS_COUNT + FAIL_COUNT)))%

EOF
