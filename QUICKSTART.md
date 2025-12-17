# Quick Start Guide

## Getting Started in 5 Minutes

### Step 1: Jenkins Setup (2 minutes)

1. **Install Jenkins plugins:**
   - GitHub plugin
   - Pipeline plugin
   - Git plugin

2. **Create new Pipeline job:**
   ```
   New Item → Multibranch Pipeline
   Name: Misc-Runtime-Pipelines
   ```

3. **Configure branch source:**
   ```
   Branch Sources → Add source → GitHub
   Repository URL: https://github.com/yldn/Misc-Runtime-Pipelines
   Credentials: (add GitHub token)
   ```

### Step 2: GitHub Webhook (1 minute)

1. Go to: `https://github.com/yldn/Misc-Runtime-Pipelines/settings/hooks`

2. Click "Add webhook"

3. Configure:
   ```
   Payload URL: http://YOUR-JENKINS-URL/github-webhook/
   Content type: application/json
   Events: Just the push event
   ```

### Step 3: Test It (2 minutes)

1. **Make a change:**
   ```bash
   echo "Test change" >> automation/test.sh
   git add automation/test.sh
   git commit -m "Test auto-update"
   git push
   ```

2. **Watch Jenkins:**
   - Job should trigger automatically
   - Pipeline runs with new changes
   - Build appears in Jenkins dashboard

## What Happens Automatically

1. **You push code** → GitHub sends webhook
2. **Jenkins receives webhook** → Triggers pipeline
3. **Pipeline detects changes** → Runs only updated scripts
4. **Results appear** in Jenkins console

## Customization

### Add Your Own Automation

Create a new script:
```bash
cd automation
cat > my-task.sh << 'EOF'
#!/bin/bash
echo "Running my custom task..."
# Your automation here
EOF
chmod +x my-task.sh
```

Add to Jenkinsfile:
```groovy
stage('My Task') {
    steps {
        sh 'chmod +x automation/my-task.sh && ./automation/my-task.sh'
    }
}
```

### Configure Pipeline Behavior

Edit `pipeline-config.yml`:
```yaml
pipelines:
  my-task:
    enabled: true
    script: automation/my-task.sh
    description: "My custom automation"
```

## Troubleshooting

**Webhook not working?**
- Check Jenkins is accessible from GitHub
- Verify webhook shows green checkmark in GitHub

**Pipeline not running?**
- Check Jenkinsfile syntax
- Review Jenkins console logs
- Ensure scripts are executable

## Next Steps

- Read [README.md](README.md) for full documentation
- See [WEBHOOK_SETUP.md](WEBHOOK_SETUP.md) for advanced webhook configuration
- Explore example scripts in `automation/` directory

## Support

Issues? Check:
1. Jenkins console output
2. GitHub webhook delivery status  
3. Repository documentation

Happy automating! 🚀
