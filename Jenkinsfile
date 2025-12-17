pipeline {
    agent any
    
    triggers {
        // Poll SCM every 5 minutes for changes
        pollSCM('H/5 * * * *')
        // GitHub webhook trigger
        githubPush()
    }
    
    options {
        // Keep only last 10 builds
        buildDiscarder(logRotator(numToKeepStr: '10'))
        // Timeout for the entire pipeline
        timeout(time: 1, unit: 'HOURS')
        // Timestamps in console output
        timestamps()
    }
    
    environment {
        // Environment variables
        PIPELINE_VERSION = '1.0.0'
        AUTOMATION_DIR = 'automation'
    }
    
    stages {
        stage('Initialize') {
            steps {
                echo "Starting Automation Pipeline v${PIPELINE_VERSION}"
                echo "Branch: ${env.BRANCH_NAME}"
                echo "Build: ${env.BUILD_NUMBER}"
                
                script {
                    // Display changed files
                    def changedFiles = sh(
                        script: 'git diff --name-only HEAD~1 HEAD || echo "First build"',
                        returnStdout: true
                    ).trim()
                    echo "Changed files:\n${changedFiles}"
                }
            }
        }
        
        stage('Detect Changes') {
            steps {
                script {
                    // Check if Jenkinsfile was changed
                    def jenkinsfileChanged = sh(
                        script: 'git diff --name-only HEAD~1 HEAD | grep -q "^Jenkinsfile" && echo "true" || echo "false"',
                        returnStdout: true
                    ).trim()
                    
                    if (jenkinsfileChanged == 'true') {
                        echo "⚠️  Jenkinsfile was updated - Pipeline will reload on next run"
                    }
                    
                    // Check if automation scripts changed
                    def automationChanged = sh(
                        script: 'git diff --name-only HEAD~1 HEAD | grep -q "^automation/" && echo "true" || echo "false"',
                        returnStdout: true
                    ).trim()
                    
                    env.AUTOMATION_CHANGED = automationChanged
                }
            }
        }
        
        stage('Run Automation Scripts') {
            when {
                expression { env.AUTOMATION_CHANGED == 'true' }
            }
            steps {
                echo "Running updated automation scripts..."
                
                script {
                    // Find and execute all automation scripts
                    def scripts = findFiles(glob: 'automation/**/*.sh')
                    
                    for (script in scripts) {
                        echo "Executing: ${script.path}"
                        sh "chmod +x ${script.path}"
                        sh "./${script.path}"
                    }
                }
            }
        }
        
        stage('Validate Pipeline Config') {
            steps {
                echo "Validating pipeline configuration..."
                
                script {
                    // Check if pipeline config files exist
                    if (fileExists('pipeline-config.yml')) {
                        echo "✓ Pipeline configuration found"
                        sh 'cat pipeline-config.yml'
                    }
                    
                    // Validate automation directory structure
                    if (fileExists('automation')) {
                        echo "✓ Automation directory exists"
                        sh 'ls -la automation/'
                    }
                }
            }
        }
        
        stage('Execute Pipelines') {
            parallel {
                stage('Build Pipeline') {
                    when {
                        expression { fileExists('automation/build.sh') }
                    }
                    steps {
                        echo "Running build automation..."
                        sh 'chmod +x automation/build.sh && ./automation/build.sh'
                    }
                }
                
                stage('Test Pipeline') {
                    when {
                        expression { fileExists('automation/test.sh') }
                    }
                    steps {
                        echo "Running test automation..."
                        sh 'chmod +x automation/test.sh && ./automation/test.sh'
                    }
                }
                
                stage('Deploy Pipeline') {
                    when {
                        expression { fileExists('automation/deploy.sh') }
                    }
                    steps {
                        echo "Running deployment automation..."
                        sh 'chmod +x automation/deploy.sh && ./automation/deploy.sh'
                    }
                }
            }
        }
        
        stage('Notify') {
            steps {
                echo "Pipeline execution completed successfully"
                
                script {
                    def summary = """
                    ===================================
                    Automation Pipeline Summary
                    ===================================
                    Build: #${env.BUILD_NUMBER}
                    Branch: ${env.BRANCH_NAME}
                    Status: SUCCESS
                    Automation Changed: ${env.AUTOMATION_CHANGED}
                    ===================================
                    """
                    echo summary
                }
            }
        }
    }
    
    post {
        success {
            echo '✓ Pipeline completed successfully'
        }
        failure {
            echo '✗ Pipeline failed'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
