pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
spec:
  containers:

  - name: gitleaks
    image: ghcr.io/gitleaks/gitleaks:v8.24.2
    command:
    - cat
    tty: true

  - name: checkov
    image: bridgecrew/checkov:latest
    command:
    - cat
    tty: true

  - name: trivy
    image: aquasec/trivy:latest
    command:
    - cat
    tty: true
'''
        }
    }

    environment {
        REPORT_DIR = "reports"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm

                sh '''
                mkdir -p ${REPORT_DIR}
                pwd
                ls -la
                '''
            }
        }

        stage('Gitleaks Secret Scan') {
            steps {
                container('gitleaks') {
                    sh '''
                    gitleaks detect \
                      --source . \
                      --report-format json \
                      --report-path ${REPORT_DIR}/gitleaks-report.json \
                      || true
                    '''
                }
            }
        }

        stage('Checkov IaC Scan') {
            steps {
                container('checkov') {
                    sh '''
                    checkov \
                      -d . \
                      -o json \
                      > ${REPORT_DIR}/checkov-report.json \
                      || true
                    '''
                }
            }
        }

        stage('Trivy Filesystem Scan') {
            steps {
                container('trivy') {
                    sh '''
                    trivy fs . \
                      --format json \
                      -o ${REPORT_DIR}/trivy-report.json \
                      || true
                    '''
                }
            }
        }

        stage('Show Results') {
            steps {
                sh '''
                echo "=============================="
                echo "Generated Reports"
                echo "=============================="

                ls -lh ${REPORT_DIR}

                echo ""
                echo "Gitleaks:"
                wc -c ${REPORT_DIR}/gitleaks-report.json || true

                echo ""
                echo "Checkov:"
                wc -c ${REPORT_DIR}/checkov-report.json || true

                echo ""
                echo "Trivy:"
                wc -c ${REPORT_DIR}/trivy-report.json || true
                '''
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'reports/*', fingerprint: true
        }

        success {
            echo 'Pipeline completed successfully'
        }

        failure {
            echo 'Pipeline failed'
        }
    }
}
