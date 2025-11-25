#!/bin/bash

# Parse arguments
NO_MINIFY=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --gf) NO_MINIFY=true ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

mkdir -p dist
touch dist/.nojekyll
TIMESTAMP=$(date +%s)

cat <<EOF > dist/QwenPersona.user.js
// ==UserScript==
// @name         QwenPersona
// @namespace    https://www.kev1nweng.space
// @version      $TIMESTAMP
// @description  Qwen Chat Custom Persona
// @author       小翁同学 (kev1nweng)
// @license      AGPL-3.0
// @match        https://chat.qwen.ai/*
// @updateURL    https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js
// @downloadURL  https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js
// @grant        none
// ==/UserScript==

EOF

if [ "$NO_MINIFY" = true ]; then
    echo "Appending raw script.js (no minification)..."
    cat script.js >> dist/QwenPersona.user.js
elif command -v npx &> /dev/null; then
    echo "Minifying script.js with terser..."
    npx --yes terser script.js --compress --mangle >> dist/QwenPersona.user.js
else
    echo "npx not found, appending raw script.js..."
    cat script.js >> dist/QwenPersona.user.js
fi
