#!/bin/bash

# Parse arguments
NO_MINIFY=false
DOMESTIC=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --gf) NO_MINIFY=true ;;
        --domestic) DOMESTIC=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

mkdir -p dist
touch dist/.nojekyll
TIMESTAMP=$(date +%s)

# Determine source file and output file based on --domestic flag
if [ "$DOMESTIC" = true ]; then
    SOURCE_FILE="script.domestic.js"
    OUTPUT_FILE="dist/QwenPersona.domestic.user.js"
    SCRIPT_NAME="QwenPersona (Domestic)"
    UPDATE_URL="https://kev1nweng.github.io/qwen-persona/QwenPersona.domestic.user.js"
    DOWNLOAD_URL="https://kev1nweng.github.io/qwen-persona/QwenPersona.domestic.user.js"
else
    SOURCE_FILE="script.js"
    OUTPUT_FILE="dist/QwenPersona.user.js"
    SCRIPT_NAME="QwenPersona"
    UPDATE_URL="https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js"
    DOWNLOAD_URL="https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js"
fi

cat <<EOF > "$OUTPUT_FILE"
// ==UserScript==
// @name         $SCRIPT_NAME
// @namespace    https://www.kev1nweng.space
// @version      $TIMESTAMP
// @description  一个便于用户自定义、保存并同步 Qwen Chat 自定义角色的 Tampermonkey 脚本。A Tampermonkey script for customizing user-defined personas in Qwen Chat.
// @author       小翁同学 (kev1nweng)
// @license      AGPL-3.0
// @match        https://chat.qwen.ai/*
// @updateURL    $UPDATE_URL
// @downloadURL  $DOWNLOAD_URL
// @grant        none
// ==/UserScript==

EOF

if [ "$NO_MINIFY" = true ]; then
    echo "Appending raw $SOURCE_FILE (no minification)..."
    cat "$SOURCE_FILE" >> "$OUTPUT_FILE"
elif command -v npx &> /dev/null; then
    echo "Minifying $SOURCE_FILE with terser..."
    npx --yes terser "$SOURCE_FILE" --compress --mangle >> "$OUTPUT_FILE"
else
    echo "npx not found, appending raw $SOURCE_FILE..."
    cat "$SOURCE_FILE" >> "$OUTPUT_FILE"
fi