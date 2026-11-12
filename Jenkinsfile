
pipeline {
    agent any

    environment {
        APP_NAME = 'Jenkins Learning'
        APP_VERSION = '1.0'
    }

    parameters {
        choice(
            name: 'DEPLOY_ENV',
            choices: ['Development', 'Testing', 'Production'],
            description: 'Select deployment environment'
        )
    }
    
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

        stage('Custom Environment Variables') {
            steps {
                echo "Application: ${env.APP_NAME}"
                echo "Environment: ${env.DEPLOY_ENV}"
                echo "Version: ${env.APP_VERSION}"
        
                bat '''
                    echo Application: %APP_NAME%
                    echo Environment: %DEPLOY_ENV%
                    echo Version: %APP_VERSION%
                '''
            }
        }

        stage('Generate Build Information') {
            steps {
                script {
                    env.BUILD_MESSAGE = "Build-${env.BUILD_NUMBER}"
                }
        
                echo "Generated value: ${env.BUILD_MESSAGE}"
            }
        }
        
        stage('Test') {
            environment {
                DEPLOY_ENV = 'Testing'
            }
        
            steps {
                echo "Received value: ${env.BUILD_MESSAGE}"
                echo "Running tests for: ${env.APP_NAME}"
                echo "Current environment: ${env.DEPLOY_ENV}"
        
                bat '''
                    echo Windows CMD environment:
                    echo %DEPLOY_ENV%
                '''
        
                bat 'if exist index.html (echo Test Passed) else (exit /b 1)'
            }
        }

        stage('Package') {
            steps {
                script {
                    writeFile(
                        file: 'release-info.txt',
                        text: """Application: ${env.APP_NAME}
                                 Version: ${env.APP_VERSION}
                                 Build Number: ${env.BUILD_NUMBER}
                                 Environment: ${params.DEPLOY_ENV}
                              """
                    )
                }
        
                echo 'Release information file created.'
        
                archiveArtifacts artifacts: 'release-info.txt',
                                 fingerprint: true
            }
        }
        
        stage('Deploy') {
            when {
                expression {
                    params.DEPLOY_ENV == 'Production'
                }
            }
            steps {
                echo "Application: ${env.APP_NAME}"
                echo "Selected environment: ${params.DEPLOY_ENV}"
                echo "Version: ${env.APP_VERSION}"
            }
        }
        
        stage('Finish') {
            steps {
                echo 'Pipeline completed successfully!'
                echo "Final pipeline environment: ${env.DEPLOY_ENV}"
                echo "Final build information: ${env.BUILD_MESSAGE}"
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
