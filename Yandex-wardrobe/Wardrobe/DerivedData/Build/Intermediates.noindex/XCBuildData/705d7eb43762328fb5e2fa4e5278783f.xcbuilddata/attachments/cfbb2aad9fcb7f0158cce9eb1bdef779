#!/bin/sh
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if [ -f "${PODS_ROOT}/SwiftLint/swiftlint" ]; then
    ${PODS_ROOT}/SwiftLint/swiftlint
else
    echo "warning: SwiftLint not found in Pods"
fi

