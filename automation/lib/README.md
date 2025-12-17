# Automation Pipeline Library

This directory contains shared functions and utilities for automation pipelines.

## Available Functions

### logging.sh
Common logging utilities for consistent output formatting.

### utils.sh
General utility functions used across automation scripts.

## Usage

Source these files in your automation scripts:

```bash
#!/bin/bash
source "$(dirname "$0")/lib/logging.sh"
source "$(dirname "$0")/lib/utils.sh"

log_info "Starting automation..."
check_prerequisites
```
