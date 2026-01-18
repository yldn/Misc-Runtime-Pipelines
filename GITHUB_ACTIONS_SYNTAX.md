# GitHub Actions - Syntax Reference

## 📚 Quick Reference Guide

### Basic Structure

```yaml
name: Workflow Name

on: [push, pull_request]  # Triggers

jobs:
  job-id:
    runs-on: ubuntu-latest
    steps:
      - name: Step Name
        run: echo "Hello"
```

---

## 🎯 Core Components

### 1. **Workflow Name**
```yaml
name: My Workflow
```

### 2. **Triggers (on)**

#### Push Events
```yaml
on:
  push:
    branches: [ main, develop ]
    paths:
      - 'src/**'
      - '!docs/**'  # Exclude paths
    tags:
      - 'v*'
```

#### Pull Requests
```yaml
on:
  pull_request:
    types: [opened, synchronize, reopened]
    branches: [ main ]
```

#### Schedule (Cron)
```yaml
on:
  schedule:
    - cron: '0 0 * * *'  # Daily at midnight
    # ┌───────────── minute (0 - 59)
    # │ ┌───────────── hour (0 - 23)
    # │ │ ┌───────────── day of month (1 - 31)
    # │ │ │ ┌───────────── month (1 - 12)
    # │ │ │ │ ┌───────────── day of week (0 - 6)
    # │ │ │ │ │
    # * * * * *
```

#### Manual Trigger
```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Target environment'
        required: true
        type: choice
        options: [dev, staging, prod]
```

#### Multiple Triggers
```yaml
on: [push, pull_request, workflow_dispatch]
```

---

### 3. **Jobs**

#### Basic Job
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Building..."
```

#### Runner Options
```yaml
runs-on: ubuntu-latest     # Ubuntu
runs-on: windows-latest    # Windows
runs-on: macos-latest      # macOS
runs-on: [self-hosted]     # Self-hosted runner
```

#### Job Dependencies
```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - run: echo "Build"
  
  test:
    needs: build  # Waits for 'build' to complete
    runs-on: ubuntu-latest
    steps:
      - run: echo "Test"
  
  deploy:
    needs: [build, test]  # Multiple dependencies
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploy"
```

---

### 4. **Steps**

#### Run Command
```yaml
steps:
  - name: Single command
    run: echo "Hello"
  
  - name: Multiple commands
    run: |
      echo "Line 1"
      echo "Line 2"
      ls -la
```

#### Use Action
```yaml
steps:
  - name: Checkout code
    uses: actions/checkout@v4
  
  - name: Setup Node
    uses: actions/setup-node@v4
    with:
      node-version: '20'
```

#### Working Directory
```yaml
steps:
  - name: Run in subdirectory
    run: npm install
    working-directory: ./frontend
```

---

### 5. **Environment Variables**

#### Job Level
```yaml
jobs:
  build:
    env:
      NODE_ENV: production
    steps:
      - run: echo $NODE_ENV
```

#### Step Level
```yaml
steps:
  - name: Use env vars
    env:
      API_KEY: ${{ secrets.API_KEY }}
      DEBUG: true
    run: echo "API_KEY is set"
```

#### Default Environment Variables
```yaml
${{ github.repository }}      # owner/repo
${{ github.ref }}             # refs/heads/main
${{ github.sha }}             # commit SHA
${{ github.actor }}           # username who triggered
${{ github.event_name }}      # push, pull_request, etc.
${{ runner.os }}              # Linux, Windows, macOS
```

---

### 6. **Conditionals**

#### If Statements
```yaml
steps:
  - name: Only on main
    if: github.ref == 'refs/heads/main'
    run: echo "Main branch"
  
  - name: Only on success
    if: success()
    run: echo "Previous steps succeeded"
  
  - name: Always run
    if: always()
    run: echo "Runs even if previous steps failed"
  
  - name: On failure
    if: failure()
    run: echo "Something failed"
```

#### Conditional Jobs
```yaml
jobs:
  deploy:
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - run: echo "Deploying..."
```

---

### 7. **Matrix Strategy**

#### Basic Matrix
```yaml
jobs:
  test:
    runs-on: ${{ matrix.os }}
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
        node: [14, 16, 18, 20]
    steps:
      - uses: actions/setup-node@v4
        with:
          node-version: ${{ matrix.node }}
```

#### Matrix with Exclusions
```yaml
strategy:
  matrix:
    os: [ubuntu-latest, windows-latest]
    node: [14, 16, 18]
    exclude:
      - os: windows-latest
        node: 14
```

#### Matrix with Inclusions
```yaml
strategy:
  matrix:
    os: [ubuntu-latest]
    node: [14, 16]
    include:
      - os: windows-latest
        node: 18
        experimental: true
```

---

### 8. **Artifacts**

#### Upload Artifacts
```yaml
steps:
  - name: Upload build
    uses: actions/upload-artifact@v4
    with:
      name: my-artifact
      path: dist/
      retention-days: 7
```

#### Download Artifacts
```yaml
steps:
  - name: Download build
    uses: actions/download-artifact@v4
    with:
      name: my-artifact
      path: dist/
```

---

### 9. **Secrets**

#### Using Secrets
```yaml
steps:
  - name: Use secret
    env:
      API_KEY: ${{ secrets.API_KEY }}
      DB_PASSWORD: ${{ secrets.DB_PASSWORD }}
    run: |
      echo "Secrets are masked in logs"
      # Use $API_KEY in your commands
```

---

### 10. **Outputs**

#### Job Outputs
```yaml
jobs:
  setup:
    runs-on: ubuntu-latest
    outputs:
      version: ${{ steps.get_version.outputs.version }}
    steps:
      - name: Get version
        id: get_version
        run: echo "version=1.2.3" >> $GITHUB_OUTPUT
  
  use-output:
    needs: setup
    runs-on: ubuntu-latest
    steps:
      - run: echo "Version is ${{ needs.setup.outputs.version }}"
```

---

### 11. **Caching**

#### Cache Dependencies
```yaml
steps:
  - name: Cache node modules
    uses: actions/cache@v4
    with:
      path: ~/.npm
      key: ${{ runner.os }}-node-${{ hashFiles('**/package-lock.json') }}
      restore-keys: |
        ${{ runner.os }}-node-
```

---

### 12. **Timeouts and Retry**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    timeout-minutes: 30  # Job timeout
    steps:
      - name: Step with timeout
        timeout-minutes: 5
        run: npm test
```

---

### 13. **Containers**

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: node:20
      credentials:
        username: ${{ secrets.DOCKER_USERNAME }}
        password: ${{ secrets.DOCKER_PASSWORD }}
    steps:
      - run: node --version
```

---

### 14. **Services** (Docker containers)

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    steps:
      - run: npm test
```

---

## 🔗 Common Actions

```yaml
# Checkout repository
- uses: actions/checkout@v4

# Setup languages/tools
- uses: actions/setup-node@v4
- uses: actions/setup-python@v5
- uses: actions/setup-java@v4
- uses: actions/setup-go@v5

# Artifacts
- uses: actions/upload-artifact@v4
- uses: actions/download-artifact@v4

# Caching
- uses: actions/cache@v4

# GitHub CLI
- uses: github/script@v7
```

---

## 📝 Best Practices

1. **Use specific action versions**: `uses: actions/checkout@v4` not `@main`
2. **Cache dependencies** to speed up workflows
3. **Use secrets** for sensitive data
4. **Set timeouts** to prevent hanging jobs
5. **Use matrix** for testing across versions/platforms
6. **Fail fast** when appropriate: `fail-fast: true`
7. **Minimize workflow runs** with path filters
8. **Use `workflow_dispatch`** for manual testing

---

## 🚀 Common Patterns

### CI/CD Pipeline
```yaml
jobs:
  build → test → deploy
```

### Multi-environment
```yaml
strategy:
  matrix:
    env: [dev, staging, prod]
```

### Conditional Deployment
```yaml
if: github.ref == 'refs/heads/main' && github.event_name == 'push'
```
