#!/bin/bash

mkdir -p dist
TIMESTAMP=$(date +%s)

cat <<EOF > dist/QwenPersona.user.js
// ==UserScript==
// @name         QwenPersona
// @namespace    https://www.kev1nweng.space
// @version      $TIMESTAMP
// @description  Qwen Chat Custom Persona
// @author       You
// @match        https://chat.qwen.ai/*
// @updateURL    https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js
// @downloadURL  https://kev1nweng.github.io/qwen-persona/QwenPersona.user.js
// @grant        none
// ==/UserScript==

EOF

if command -v npx &> /dev/null; then
    echo "Minifying script.js with terser..."
    npx --yes terser script.js --compress --mangle >> dist/QwenPersona.user.js
else
    echo "npx not found, appending raw script.js..."
    cat script.js >> dist/QwenPersona.user.js
fi
