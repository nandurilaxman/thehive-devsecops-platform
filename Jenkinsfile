pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Gitleaks') {
            steps {
                sh '''
                wget -qO gitleaks.tar.gz https://github.com/gitleaks/gitleaks/releases/download/v8.24.2/gitleaks_8.24.2_linux_x64.tar.gz
                tar -xzf gitleaks.tar.gz
                chmod +x gitleaks
                '''
            }
        }

        stage('Secret Scan') {
            steps {
                sh '''
                ./gitleaks detect --source . --verbose
                '''
            }
        }
    }
}
