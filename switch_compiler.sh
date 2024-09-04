#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <gcc14|clang18|msvc22>"
    exit 1
fi

case $1 in
    gcc14|clang18|msvc22)
        # Use sed to replace the service line in devcontainer.json
        sed -i.bak 's/"service": ".*"/"service": "'$1'"/' .devcontainer/devcontainer.json
        echo "Switched to $1. Please rebuild and reopen the container in VS Code."
        ;;
    *)
        echo "Invalid compiler. Use gcc14, clang18, or msvc22."
        exit 1
        ;;
esac