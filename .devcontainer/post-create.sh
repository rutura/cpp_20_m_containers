#!/bin/sh

# Detect the operating system
if [ "$(uname)" = "Darwin" ]; then
    # macOS
    sudo chown -R developer:staff /workspace
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Linux
    sudo chown -R developer:developer /workspace
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" = "MINGW64_NT" ]; then
    # Windows
    echo "Running on Windows - no chown needed"
else
    echo "Unknown operating system"
fi

