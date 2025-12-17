#!/bin/bash
# Utility functions for automation scripts

# Check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
check_prerequisites() {
    local missing_tools=()
    
    for tool in "$@"; do
        if ! command_exists "$tool"; then
            missing_tools+=("$tool")
        fi
    done
    
    if [ ${#missing_tools[@]} -gt 0 ]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        return 1
    fi
    
    return 0
}

# Get git branch name
get_git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown"
}

# Get git commit hash
get_git_commit() {
    git rev-parse --short HEAD 2>/dev/null || echo "unknown"
}

# Check if running in CI environment
is_ci() {
    [ -n "$CI" ] || [ -n "$JENKINS_HOME" ] || [ -n "$GITHUB_ACTIONS" ]
}

# Create directory if it doesn't exist
ensure_directory() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        log_info "Created directory: $dir"
    fi
}

# Optional cleanup function - scripts can override this
# Note: If you source this library and need custom cleanup,
# define your own cleanup function AFTER sourcing this file
cleanup() {
    # Default cleanup - can be overridden by sourcing script
    :
}

# Set trap only if not already set
# Scripts can disable this by unsetting the trap after sourcing
if [ -z "$UTILS_TRAP_SET" ]; then
    trap cleanup EXIT
    export UTILS_TRAP_SET=1
fi
