
pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo 'Starting build...'
                bat 'call build.bat'
            }
        }

        stage('Test') {
            steps {
                echo 'Running validation tests...'
                bat 'if exist index.html (echo Test Passed) else (exit /b 1)'
            }
        }

        stage('Finish') {
            steps {
                echo 'Pipeline completed successfully!'
            }
        }
    }
}
