#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <gcc14|clang18|msvc22>"
    exit 1
fi

DEVCONTAINER_DIR=".devcontainer"
DEVCONTAINER_PATH="$DEVCONTAINER_DIR/devcontainer.json"
DOCKER_COMPOSE_PATH="docker-compose.yml"

setup_environment() {
    local env_type=$1
    echo "Setting up $env_type development environment..."
    
    local devcontainer_env_path="$DEVCONTAINER_DIR/devcontainer.$env_type.json"
    local docker_compose_env_path="docker-compose.$env_type.yml"

    if [ -f "$devcontainer_env_path" ]; then
        cp "$devcontainer_env_path" "$DEVCONTAINER_PATH"
        echo "Copied $devcontainer_env_path to $DEVCONTAINER_PATH"
    else
        echo "Warning: $devcontainer_env_path not found"
    fi

    if [ -f "$docker_compose_env_path" ]; then
        cp "$docker_compose_env_path" "$DOCKER_COMPOSE_PATH"
        echo "Copied $docker_compose_env_path to $DOCKER_COMPOSE_PATH"
    else
        echo "Warning: $docker_compose_env_path not found"
    fi

    echo "$env_type setup complete."
}

if [ ! -d "$DEVCONTAINER_DIR" ]; then
    echo "Error: .devcontainer folder not found. Make sure you're in the correct directory."
    exit 1
fi

case $1 in
    gcc14|clang18)
        setup_environment "unix"
        ;;
    msvc22)
        setup_environment "windows"
        ;;
    *)
        echo "Invalid compiler. Use gcc14, clang18, or msvc22."
        exit 1
        ;;
esac

# Update the service in devcontainer.json
sed -i.bak 's/"service": ".*"/"service": "'$1'"/' "$DEVCONTAINER_PATH"

echo "Switched to $1."
echo "Please rebuild and reopen the container in VS Code."
echo "Use 'Remote-Containers: Rebuild and Reopen in Container' from the command palette."