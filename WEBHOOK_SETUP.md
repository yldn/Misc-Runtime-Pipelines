# GitHub Webhook Configuration for Jenkins

This document explains how to configure GitHub webhooks to automatically trigger Jenkins pipeline updates when repository changes occur.

## Prerequisites

- Jenkins server accessible from GitHub
- Jenkins GitHub plugin installed
- GitHub repository with admin access

## Setup Steps

### 1. Configure Jenkins

1. **Install Required Plugins:**
   - GitHub plugin
   - GitHub Branch Source plugin
   - Pipeline plugin
   - Generic Webhook Trigger plugin

2. **Create Jenkins Credentials:**
   - Go to: `Manage Jenkins` → `Manage Credentials`
   - Add GitHub personal access token with `repo` and `admin:repo_hook` permissions

3. **Configure GitHub Server:**
   - Go to: `Manage Jenkins` → `Configure System`
   - Under GitHub, add GitHub server
   - Add credentials created above

### 2. Create Jenkins Job

1. **Create Multibranch Pipeline:**
   ```
   - New Item → Multibranch Pipeline
   - Name: Misc-Runtime-Pipelines
   - Branch Sources → Add source → GitHub
   - Select credentials
   - Repository HTTPS URL: https://github.com/yldn/Misc-Runtime-Pipelines
   ```

2. **Configure Build Configuration:**
   ```
   - Mode: by Jenkinsfile
   - Script Path: Jenkinsfile
   ```

3. **Scan Multibranch Pipeline Triggers:**
   ```
   - Enable: Scan by webhook
   - Trigger token: misc-pipelines-webhook
   ```

### 3. Configure GitHub Webhook

1. **Go to Repository Settings:**
   - Navigate to: `Settings` → `Webhooks` → `Add webhook`

2. **Webhook Configuration:**
   ```
   Payload URL: http://YOUR-JENKINS-URL/github-webhook/
   Content type: application/json
   Secret: (optional, recommended for security)
   SSL verification: Enable (if using HTTPS)
   ```

3. **Select Events:**
   - [x] Push events
   - [x] Pull request events
   - [ ] Everything else (optional)

4. **Activate Webhook:**
   - [x] Active
   - Click "Add webhook"

### 4. Alternative: Generic Webhook Trigger

If you need more control, use Generic Webhook Trigger:

1. **Install Generic Webhook Trigger Plugin**

2. **Configure in Jenkinsfile:**
   ```groovy
   properties([
       pipelineTriggers([
           GenericTrigger(
               genericVariables: [
                   [key: 'ref', value: '$.ref'],
                   [key: 'repository', value: '$.repository.full_name']
               ],
               token: 'misc-pipelines-webhook-token',
               causeString: 'Triggered by GitHub webhook',
               printContributedVariables: true,
               printPostContent: true
           )
       ])
   ])
   ```

3. **GitHub Webhook URL:**
   ```
   http://YOUR-JENKINS-URL/generic-webhook-trigger/invoke?token=misc-pipelines-webhook-token
   ```

## Auto-Update Mechanism

The Jenkinsfile includes automatic change detection:

1. **Poll SCM Trigger:**
   - Checks repository every 5 minutes
   - Trigger: `H/5 * * * *`

2. **GitHub Push Trigger:**
   - Immediate trigger via webhook
   - Faster than polling

3. **Change Detection:**
   - Detects when Jenkinsfile is modified
   - Automatically reloads pipeline configuration
   - Runs updated automation scripts

## Verification

1. **Test the Webhook:**
   - Make a commit to the repository
   - Push to GitHub
   - Check Jenkins job for new build
   - Verify webhook delivery in GitHub Settings → Webhooks → Recent Deliveries

2. **Manual Trigger:**
   ```bash
   curl -X POST http://YOUR-JENKINS-URL/github-webhook/
   ```

## Security Best Practices

1. **Use HTTPS** for Jenkins URL
2. **Set webhook secret** in GitHub
3. **Validate webhook signatures** in Jenkins
4. **Restrict Jenkins access** with proper authentication
5. **Use least-privilege credentials**

## Troubleshooting

### Webhook not triggering:

1. Check Jenkins is accessible from GitHub
2. Verify webhook delivery status in GitHub
3. Check Jenkins system log for webhook receipts
4. Ensure GitHub plugin is properly configured

### Pipeline not updating:

1. Verify Jenkinsfile syntax
2. Check branch configuration in multibranch pipeline
3. Manually trigger "Scan Repository Now"
4. Check Jenkins job configuration

## References

- [Jenkins GitHub Plugin](https://plugins.jenkins.io/github/)
- [GitHub Webhooks Documentation](https://docs.github.com/en/developers/webhooks-and-events/webhooks)
- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
