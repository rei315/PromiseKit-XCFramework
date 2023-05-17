#!/bin/bash

make_release_and_upload_xcframework() {
    local GITHUB_TOKEN=$1
    local RELEASE_TAG=$2
    REPO_OWNER="rei315"
    REPO_NAME="PromiseKit-XCFramework"
    
    RELEASE_NAME="Release v$RELEASE_TAG"
    RELEASE_BODY="XCFramework for PromiseKit"
    
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
}

GITHUB_TOKEN="$1"
RELEASE_TAG="$2"

make_release_and_upload_xcframework $GITHUB_TOKEN $RELEASE_TAG
