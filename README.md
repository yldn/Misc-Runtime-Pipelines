# Misc-Runtime-Pipelines

A comprehensive collection of CI/CD pipeline examples and learning resources for Jenkins and GitHub Actions.

## 📁 Repository Structure

```
├── .github/
│   └── workflows/          # GitHub Actions workflows
│       ├── 01-hello-world.yml
│       ├── 02-checkout-and-build.yml
│       ├── 03-matrix-strategy.yml
│       ├── 04-nodejs-demo.yml
│       ├── 05-conditional-jobs.yml
│       ├── 06-advanced-triggers.yml
│       └── test-demo.yml
├── Jenkinsfile            # Jenkins pipeline example
├── GITHUB_ACTIONS_GUIDE.md   # Complete learning guide
├── GITHUB_ACTIONS_SYNTAX.md  # Syntax reference
└── README.md              # This file
```

## 🚀 Getting Started with GitHub Actions

### Quick Start

1. **Start Learning**: Read [`GITHUB_ACTIONS_GUIDE.md`](./GITHUB_ACTIONS_GUIDE.md)
2. **Syntax Reference**: Check [`GITHUB_ACTIONS_SYNTAX.md`](./GITHUB_ACTIONS_SYNTAX.md)
3. **Try Examples**: Run the workflows in `.github/workflows/`

### Recommended Learning Order

1. **Beginner**: Start with `01-hello-world.yml`
2. **Intermediate**: Progress through `02` to `04`
3. **Advanced**: Study `05` and `06`
4. **Practice**: Use `test-demo.yml` for hands-on testing

### Running Workflows

#### Automatic Triggers
- Push code to your repository
- Create a pull request
- Workflows run automatically based on configured triggers

#### Manual Testing
1. Go to your GitHub repository
2. Click **Actions** tab
3. Select **🧪 Test & Demo Workflow**
4. Click **Run workflow**
5. Choose test type and click **Run workflow**

## 📚 What's Included

### GitHub Actions Workflows

| File | Description | Level |
|------|-------------|-------|
| `01-hello-world.yml` | Basic workflow structure and triggers | Beginner |
| `02-checkout-and-build.yml` | Working with repository code | Beginner |
| `03-matrix-strategy.yml` | Multi-platform testing | Intermediate |
| `04-nodejs-demo.yml` | Complete Node.js CI/CD pipeline | Intermediate |
| `05-conditional-jobs.yml` | Job dependencies and conditionals | Advanced |
| `06-advanced-triggers.yml` | All trigger types and inputs | Advanced |
| `test-demo.yml` | Interactive testing playground | All Levels |

### Documentation

- **GITHUB_ACTIONS_GUIDE.md**: Complete learning guide with exercises
- **GITHUB_ACTIONS_SYNTAX.md**: Comprehensive syntax reference

### Key Topics Covered

✅ Workflow basics and structure  
✅ Event triggers (push, PR, schedule, manual)  
✅ Jobs, steps, and runners  
✅ Matrix builds for multi-platform testing  
✅ Artifacts and caching  
✅ Environment variables and secrets  
✅ Conditional execution  
✅ Job dependencies and outputs  
✅ Real-world CI/CD patterns  

## 🎯 How to Run Workflows

### Method 1: Push to Repository
```bash
git add .
git commit -m "Test GitHub Actions"
git push origin main
```

### Method 2: Manual Trigger
Perfect for the `test-demo.yml` workflow:
1. Navigate to **Actions** tab
2. Select workflow
3. Click **Run workflow**
4. Configure inputs
5. Click **Run workflow** button

### Method 3: Pull Request
Create a PR to trigger workflows configured with `pull_request` events.

## 🔍 Monitoring Workflows

1. Go to **Actions** tab in your repository
2. See all workflow runs with status indicators
3. Click a run to view job details
4. Click a job to see step-by-step logs
5. Download artifacts if generated

## 💡 Use Cases

### Continuous Integration
- Run tests on every push
- Build across multiple platforms
- Lint and format code
- Run security scans

### Continuous Deployment
- Deploy to staging/production
- Create releases
- Publish packages
- Update documentation

### Automation
- Scheduled tasks (cron jobs)
- Issue/PR management
- Notifications
- Custom workflows

## 🛠️ Example Projects

### Node.js Application
See `04-nodejs-demo.yml` for:
- Installing dependencies
- Running tests
- Building application
- Uploading artifacts

### Multi-Platform Testing
See `03-matrix-strategy.yml` for:
- Testing on Linux, Windows, macOS
- Multiple language versions
- Parallel execution

### CI/CD Pipeline
See `05-conditional-jobs.yml` for:
- Build → Test → Deploy flow
- Conditional deployment
- Job dependencies

## 📖 Learning Resources

### In This Repository
- 📘 [Complete Guide](./GITHUB_ACTIONS_GUIDE.md)
- 📙 [Syntax Reference](./GITHUB_ACTIONS_SYNTAX.md)
- 🧪 [Test Workflows](./.github/workflows/)

### External Resources
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
- [Community Forum](https://github.community/)

## 🚦 Workflow Status Indicators

- 🟢 **Success**: All jobs completed successfully
- 🔴 **Failure**: One or more jobs failed
- 🟡 **In Progress**: Workflow is currently running
- ⚫ **Queued**: Waiting to start
- ⚪ **Skipped**: Job was skipped (conditional)

## 🎓 Practice Exercises

1. **Modify `01-hello-world.yml`** to print your name
2. **Create a new workflow** that runs on a schedule
3. **Add a matrix build** to test multiple versions
4. **Upload and download artifacts** between jobs
5. **Create a manual workflow** with custom inputs

## 🤝 Contributing

This is a learning repository. Feel free to:
- Add new example workflows
- Improve documentation
- Share your own patterns
- Report issues or suggestions

## 📝 Notes

- **Free tier limits**: GitHub provides free minutes for Actions
- **Private repos**: Different minute limits apply
- **Self-hosted runners**: Available for unlimited usage
- **Logs retention**: Workflow logs kept for 90 days

## ⚡ Quick Tips

1. Start with `test-demo.yml` for interactive learning
2. Use `workflow_dispatch` for testing without pushing commits
3. Check the Actions tab frequently to see results
4. Read error logs carefully - they're very helpful
5. Use the syntax reference when building workflows

## 🎉 Next Steps

1. ✅ Push this repository to GitHub
2. ✅ Go to the Actions tab
3. ✅ Run the `test-demo.yml` workflow
4. ✅ Explore the logs and results
5. ✅ Start building your own workflows!

---

## 🔧 Jenkins Pipeline

The `Jenkinsfile` contains Jenkins pipeline examples for comparison with GitHub Actions.

---

**Happy Learning! 🚀**

For detailed instructions, see [GITHUB_ACTIONS_GUIDE.md](./GITHUB_ACTIONS_GUIDE.md)
