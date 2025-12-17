# Misc-Runtime-Pipelines

Automated Jenkins pipelines that automatically update when repository changes are detected.

## Overview

This repository contains automation pipelines that run on Jenkins with automatic updates. When changes are pushed to this repository, the Jenkins pipeline automatically reloads and runs the updated automation scripts.

## Features

- 🔄 **Auto-Update**: Pipeline automatically reloads when Jenkinsfile changes
- 🔔 **GitHub Webhooks**: Instant triggering on push/PR events
- 📊 **Change Detection**: Automatically detects which automation scripts changed
- 🔧 **Modular Scripts**: Separate automation scripts for build, test, and deploy
- 📝 **Configurable**: YAML-based pipeline configuration
- 🛠️ **Shared Libraries**: Reusable utilities and logging functions

## Structure

```
.
├── Jenkinsfile              # Main Jenkins pipeline definition
├── pipeline-config.yml      # Pipeline configuration
├── automation/              # Automation scripts
│   ├── build.sh            # Build automation
│   ├── test.sh             # Test automation
│   ├── deploy.sh           # Deploy automation
│   └── lib/                # Shared libraries
│       ├── logging.sh      # Logging utilities
│       └── utils.sh        # Common utilities
└── WEBHOOK_SETUP.md        # Webhook configuration guide
```

## Quick Start

### 1. Setup Jenkins

1. Install required Jenkins plugins:
   - GitHub plugin
   - Pipeline plugin
   - Generic Webhook Trigger plugin

2. Create a Multibranch Pipeline job:
   - Point to this repository
   - Use `Jenkinsfile` as the pipeline script

### 2. Configure GitHub Webhook

See [WEBHOOK_SETUP.md](WEBHOOK_SETUP.md) for detailed instructions.

Quick setup:
- Go to repository Settings → Webhooks
- Add webhook: `http://YOUR-JENKINS-URL/github-webhook/`
- Select: Push events, Pull request events

### 3. Make Changes

The pipeline automatically updates when you:
- Modify `Jenkinsfile`
- Update automation scripts in `automation/`
- Change pipeline configuration in `pipeline-config.yml`

## Pipeline Behavior

### Automatic Updates

The Jenkinsfile includes:
- **Poll SCM**: Checks for changes every 5 minutes
- **GitHub Webhook**: Immediate trigger on push
- **Change Detection**: Identifies modified files
- **Script Execution**: Runs only updated automation scripts

### Parallel Execution

The pipeline runs multiple automation stages in parallel:
- Build automation
- Test automation  
- Deploy automation

Each stage only runs if the corresponding script exists.

## Automation Scripts

### Adding New Scripts

1. Create a new shell script in `automation/`:
   ```bash
   #!/bin/bash
   source "$(dirname "$0")/lib/logging.sh"
   
   log_section "My Automation"
   log_info "Running custom automation..."
   ```

2. Make it executable:
   ```bash
   chmod +x automation/my-script.sh
   ```

3. Add to Jenkinsfile (optional):
   ```groovy
   stage('My Automation') {
       when {
           expression { fileExists('automation/my-script.sh') }
       }
       steps {
           sh 'chmod +x automation/my-script.sh && ./automation/my-script.sh'
       }
   }
   ```

### Using Shared Libraries

```bash
#!/bin/bash
source "$(dirname "$0")/lib/logging.sh"
source "$(dirname "$0")/lib/utils.sh"

log_info "Starting automation..."
check_prerequisites git curl

branch=$(get_git_branch)
log_success "Running on branch: $branch"
```

## Configuration

Edit `pipeline-config.yml` to customize:
- Enable/disable specific pipelines
- Configure triggers
- Set webhook preferences
- Adjust notification settings

## Development

### Testing Locally

Run automation scripts locally:
```bash
cd automation
./build.sh
./test.sh
```

### Testing Jenkins Pipeline

Use Jenkins Pipeline Syntax validator:
```bash
# In Jenkins: Pipeline Syntax → Declarative Directive Generator
```

## Troubleshooting

### Pipeline Not Triggering

1. Check webhook delivery in GitHub Settings
2. Verify Jenkins GitHub plugin configuration
3. Check Jenkins system log for webhook receipts

### Scripts Not Running

1. Ensure scripts have execute permissions
2. Check script paths in Jenkinsfile
3. Review Jenkins job console output

## Contributing

1. Create a feature branch
2. Add/modify automation scripts
3. Test locally
4. Push and create PR
5. Jenkins will automatically run the updated pipeline

## License

MIT License - See LICENSE file for details
