pipeline {
	agent any

	options {
		wrap([$class: 'TimestamperBuildWrapper'])
		wrap([$class: 'AnsiColorBuildWrapper', colorMapName: 'xterm'])
		buildDiscarder(logRotator(numToKeepStr: '20'))
		disableConcurrentBuilds()
	}

	environment {
		APP_NAME = 'misc-runtime-pipelines'
	}

	stages {
		stage('Checkout') {
			steps {
				checkout scm
				echo "Repo: ${env.GIT_URL ?: 'unknown'}"
				echo "Branch: ${env.BRANCH_NAME ?: 'unknown'}"
				echo "Commit: ${env.GIT_COMMIT ?: 'unknown'}"
				echo "Webhook/PR: CHANGE_ID=${env.CHANGE_ID ?: 'n/a'} CHANGE_TARGET=${env.CHANGE_TARGET ?: 'n/a'}"
				echo "Jenkins: JOB_NAME=${env.JOB_NAME ?: 'unknown'} BUILD_URL=${env.BUILD_URL ?: 'unknown'}"
			}
		}

		stage('Groovy Practice') {
			steps {
				script {
					def changed = []
					try {
						if (isUnix()) {
							changed = sh(returnStdout: true, script: 'git diff --name-only HEAD~1..HEAD || true').trim().split('\\n') as List
						} else {
							def out = bat(returnStdout: true, script: '@echo off\r\ngit diff --name-only HEAD~1..HEAD 2>NUL').trim()
							changed = out ? out.split('\\r?\\n') as List : []
						}
					} catch (ignored) {
						// On shallow clones or atypical checkouts, diff may be unavailable.
						changed = []
					}
					changed = changed.findAll { it?.trim() }
					echo "Changed files: ${changed.isEmpty() ? '(none detected)' : changed.join(', ')}"

					def isPR = !!env.CHANGE_ID
					echo "Is PR build: ${isPR}"

					def msg = isPR ? "Validating PR #${env.CHANGE_ID}" : "Building branch ${env.BRANCH_NAME}"
					echo msg
				}
			}
		}

		stage('Unit Test (demo)') {
			steps {
				echo 'No tests yet. Add tests and run them here.'
			}
		}

		stage('Build (demo)') {
			steps {
				echo "Building ${env.APP_NAME}... (placeholder)"
			}
		}

		stage('Deploy (main only)') {
			when {
				allOf {
					branch 'main'
					not { buildingTag() }
				}
			}
			steps {
				echo 'Deploy step placeholder (only runs on main).'
			}
		}
	}

	post {
		always {
			echo 'Post: always'
		}
		success {
			echo 'Post: success'
		}
		failure {
			echo 'Post: failure'
		}
	}
}
