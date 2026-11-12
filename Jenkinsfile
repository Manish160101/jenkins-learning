
pipeline {
    agent any

    stages {

        stage('Build') {
            steps {
                echo 'Starting build...'
                bat 'call build.bat'
            }
        }

        stage('Environment Information') {
            steps {
                echo "Job Name: ${env.JOB_NAME}"
                echo "Build Number: ${env.BUILD_NUMBER}"
                echo "Build ID: ${env.BUILD_ID}"
                echo "Workspace: ${env.WORKSPACE}"
                echo "Build URL: ${env.BUILD_URL}"
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

    post {
        always {
            echo 'Pipeline execution has finished.'
        }

        success {
            echo 'Congratulations! Pipeline SUCCESS.'
        }

        failure {
            echo 'Pipeline FAILED. Please check Console Output.'
        }
    }
}
