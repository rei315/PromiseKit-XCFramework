#!/bin/bash

GITHUB_TOKEN="$1"

REPO_OWNER="rei315"
REPO_NAME="PromiseKit-XCFramework"

RELEASE_TAG="v1.0.0"
RELEASE_NAME="Release v1.0.0"
RELEASE_BODY="XCFramework for PromiseKit"

FILE_PATH="PromiseKit.xcframework"

RELEASES_URL="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases"

CREATE_RELEASE_RESPONSE=$(curl \
  -XPOST \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "tag_name": "'"$RELEASE_TAG"'",
    "name": "'"$RELEASE_NAME"'",
    "body": "'"$RELEASE_BODY"'",
    "draft": false,
    "prerelease": false
  }' \
  $RELEASES_URL)

RELEASE_ID=$(echo $CREATE_RELEASE_RESPONSE | jq '.id')

if [[ $RELEASE_ID != "null" ]]; then
  echo "New release created with ID: $RELEASE_ID"

  UPLOAD_URL="https://uploads.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/$RELEASE_ID/assets?name=$(basename $FILE_PATH)"

  UPLOAD_RESPONSE=$(curl \
    -XPOST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Content-Type: $(file -b --mime-type $FILE_PATH)" \
    --data-binary @$FILE_PATH \
    $UPLOAD_URL)

  echo "File uploaded successfully"
else
  echo "Failed to create new release"
fi
