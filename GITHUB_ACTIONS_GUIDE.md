# 🚀 GitHub Actions - Complete Learning Guide

Welcome to GitHub Actions! This guide will help you get started and master the basics of CI/CD automation.

## 📋 Table of Contents
1. [What is GitHub Actions?](#what-is-github-actions)
2. [Getting Started](#getting-started)
3. [Learning Path](#learning-path)
4. [Running Workflows](#running-workflows)
5. [Troubleshooting](#troubleshooting)
6. [Resources](#resources)

---

## 🤔 What is GitHub Actions?

GitHub Actions is a CI/CD (Continuous Integration/Continuous Deployment) platform that allows you to automate your software workflows directly in your GitHub repository.

### Key Concepts:

- **Workflow**: An automated process defined in YAML
- **Event**: A trigger that starts a workflow (push, pull request, schedule, etc.)
- **Job**: A set of steps that run on the same runner
- **Step**: An individual task (run a command or use an action)
- **Action**: A reusable unit of code
- **Runner**: A server that runs your workflows

---

## 🎯 Getting Started

### Prerequisites
✅ A GitHub account  
✅ A GitHub repository  
✅ Basic YAML knowledge (you'll learn as you go!)

### Your First Workflow

1. **Create workflow directory**:
   ```
   .github/workflows/
   ```

2. **Create a workflow file**: `hello.yml`
   ```yaml
   name: My First Workflow
   
   on: [push]
   
   jobs:
     greet:
       runs-on: ubuntu-latest
       steps:
         - name: Say hello
           run: echo "Hello, GitHub Actions!"
   ```

3. **Commit and push** to your repository

4. **Check the Actions tab** in your GitHub repository to see it run!

---

## 📚 Learning Path

This repository includes progressive examples to help you learn:

### Level 1: Basics
**File**: `.github/workflows/01-hello-world.yml`
- ✅ Basic workflow structure
- ✅ Simple triggers
- ✅ Running commands

**Try it**: Commit this file and watch it run automatically!

### Level 2: Working with Code
**File**: `.github/workflows/02-checkout-and-build.yml`
- ✅ Checkout repository code
- ✅ Environment variables
- ✅ Multi-line commands

**Try it**: See how to access your repository files in the workflow.

### Level 3: Testing Across Platforms
**File**: `.github/workflows/03-matrix-strategy.yml`
- ✅ Matrix builds
- ✅ Multiple OS support
- ✅ Conditional steps

**Try it**: Run tests on Linux, Windows, and macOS simultaneously!

### Level 4: Real-World Example
**File**: `.github/workflows/04-nodejs-demo.yml`
- ✅ Building a Node.js application
- ✅ Running tests
- ✅ Uploading artifacts

**Try it**: See a complete CI pipeline in action.

### Level 5: Advanced Workflows
**File**: `.github/workflows/05-conditional-jobs.yml`
- ✅ Job dependencies
- ✅ Conditional execution
- ✅ Job outputs
- ✅ Artifact sharing

**Try it**: Learn how jobs communicate and depend on each other.

### Level 6: Complex Triggers
**File**: `.github/workflows/06-advanced-triggers.yml`
- ✅ Path filters
- ✅ Scheduled runs
- ✅ Manual triggers with inputs

**Try it**: Master all the ways to trigger workflows.

### 🧪 Test & Demo Workflow
**File**: `.github/workflows/test-demo.yml`
- ✅ Interactive testing
- ✅ Multiple test scenarios
- ✅ Custom inputs

**Try it**: Your interactive playground for testing concepts!

---

## 🏃 Running Workflows

### Method 1: Automatic Triggers

Most workflows run automatically when you:
- **Push code** to a branch
- **Create a pull request**
- **Create a tag**

Just commit your workflow file and it will trigger based on the `on:` events you defined.

### Method 2: Manual Triggers (workflow_dispatch)

1. Go to your GitHub repository
2. Click the **"Actions"** tab
3. Select a workflow from the left sidebar
4. Click **"Run workflow"** button (appears for workflows with `workflow_dispatch`)
5. Fill in any inputs
6. Click **"Run workflow"**

**Best for learning**: The `test-demo.yml` workflow is perfect for manual testing!

### Method 3: Scheduled Runs

Workflows with `schedule` triggers run automatically based on cron syntax:
```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight UTC
```

---

## 🔍 Monitoring Workflows

### View Workflow Runs:

1. Go to **Actions** tab in your repository
2. See list of all workflow runs
3. Click on a run to see details
4. Click on a job to see step-by-step logs

### Understanding Status Icons:

- 🟢 **Green checkmark**: Success
- 🔴 **Red X**: Failed
- 🟡 **Yellow circle**: In progress
- ⚫ **Gray circle**: Queued/waiting

---

## 🛠️ Troubleshooting

### Common Issues:

#### 1. Workflow not running?
- ✅ Check file is in `.github/workflows/` directory
- ✅ File has `.yml` or `.yaml` extension
- ✅ YAML syntax is correct (use a YAML validator)
- ✅ Trigger events match your actions

#### 2. Syntax errors?
- ✅ Indentation matters in YAML (use 2 spaces)
- ✅ Check quotes and special characters
- ✅ Validate YAML: https://www.yamllint.com/

#### 3. Job failing?
- ✅ Check the logs in the Actions tab
- ✅ Look for error messages in red
- ✅ Verify commands work locally
- ✅ Check environment variables and secrets

#### 4. Can't find a file?
- ✅ Use `actions/checkout@v4` to checkout your code first
- ✅ Check working directory with `pwd`
- ✅ List files with `ls -la`

### Debugging Tips:

```yaml
# Add debug steps to your workflow
- name: Debug - Show environment
  run: |
    echo "Current directory: $(pwd)"
    echo "List files:"
    ls -la
    echo "Environment variables:"
    env | sort

- name: Debug - Show context
  run: |
    echo "GitHub Context:"
    echo "Repository: ${{ github.repository }}"
    echo "Ref: ${{ github.ref }}"
    echo "Actor: ${{ github.actor }}"
```

---

## 📖 Quick Reference

### Essential Commands:

```yaml
# Checkout code
- uses: actions/checkout@v4

# Run shell commands
- run: echo "Hello"

# Use environment variables
- env:
    MY_VAR: value
  run: echo $MY_VAR

# Conditional execution
- if: success()
  run: echo "Previous step succeeded"
```

### Essential Context Variables:

```yaml
${{ github.repository }}   # Repository name
${{ github.ref }}          # Branch/tag reference
${{ github.sha }}          # Commit SHA
${{ github.actor }}        # User who triggered
${{ runner.os }}           # Operating system
```

---

## 🎓 Practice Exercises

### Exercise 1: Hello World
1. Create `hello-world.yml`
2. Make it print "Hello, [Your Name]!"
3. Trigger on push to main

### Exercise 2: Multi-Step
1. Create a workflow with 3 steps
2. First step: Print date
3. Second step: Create a file
4. Third step: Read the file

### Exercise 3: Matrix Build
1. Test across Ubuntu, Windows, macOS
2. Print the OS name in each job
3. Use conditional steps for OS-specific commands

### Exercise 4: Manual Trigger
1. Add `workflow_dispatch` with inputs
2. Accept a "name" input
3. Print "Hello, [name]!" using the input

---

## 📚 Additional Resources

### Official Documentation
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Workflow Syntax](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

### Learning Resources
- [GitHub Actions Learning Lab](https://lab.github.com/)
- [GitHub Actions Cheat Sheet](https://github.github.io/actions-cheat-sheet/)

### Community
- [GitHub Community Forum](https://github.community/)
- [GitHub Actions on Stack Overflow](https://stackoverflow.com/questions/tagged/github-actions)

### Files in This Repository
- 📄 `GITHUB_ACTIONS_SYNTAX.md` - Complete syntax reference
- 📁 `.github/workflows/` - Example workflows
  - `01-hello-world.yml` - Start here!
  - `02-checkout-and-build.yml` - Working with code
  - `03-matrix-strategy.yml` - Multi-platform testing
  - `04-nodejs-demo.yml` - Real-world example
  - `05-conditional-jobs.yml` - Advanced job control
  - `06-advanced-triggers.yml` - All trigger types
  - `test-demo.yml` - Interactive testing playground

---

## 🚀 Next Steps

1. ✅ Read through the example workflows
2. ✅ Try the `test-demo.yml` workflow manually
3. ✅ Modify examples to fit your needs
4. ✅ Explore the syntax reference guide
5. ✅ Build your own workflow!

---

## 💡 Pro Tips

1. **Start simple**: Begin with basic workflows and add complexity gradually
2. **Use workflow_dispatch**: Great for testing without pushing commits
3. **Check the Marketplace**: Thousands of pre-built actions available
4. **Cache dependencies**: Speed up workflows with caching
5. **Use matrix builds**: Test across multiple versions/platforms efficiently
6. **Set timeouts**: Prevent workflows from running too long
7. **Monitor usage**: GitHub provides free minutes, but they're limited
8. **Use secrets**: Never hardcode sensitive data in workflows

---

## ❓ Need Help?

- Check the [Troubleshooting](#troubleshooting) section
- Review workflow logs in the Actions tab
- Consult the [syntax reference](./GITHUB_ACTIONS_SYNTAX.md)
- Search [GitHub Discussions](https://github.com/orgs/community/discussions/categories/actions)

---

## 🎉 You're Ready!

You now have everything you need to start with GitHub Actions. Pick a workflow, try it out, and start automating!

**Happy automating! 🚀**
