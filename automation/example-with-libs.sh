#!/bin/bash
# Example automation script using shared libraries

# Source shared libraries
SCRIPT_DIR="$(dirname "$0")"
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/utils.sh"

# Main automation logic
log_section "Example Automation with Shared Libraries"

log_info "Starting example automation..."
log_info "Current directory: $(pwd)"

# Get git information
branch=$(get_git_branch)
commit=$(get_git_commit)

log_info "Git branch: $branch"
log_info "Git commit: $commit"

# Check if running in CI
if is_ci; then
    log_info "Running in CI environment"
else
    log_warning "Not running in CI environment"
fi

# Check prerequisites (example)
log_info "Checking prerequisites..."
if check_prerequisites git bash; then
    log_success "All prerequisites met"
else
    log_error "Some prerequisites are missing"
    exit 1
fi

# Create example directory
ensure_directory "output"

log_success "Example automation completed successfully!"
