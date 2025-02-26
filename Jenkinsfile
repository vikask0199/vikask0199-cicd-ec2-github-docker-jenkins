pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-username/cicd-pipeline.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'pnpm install'
            }
        }

        stage('Build') {
            steps {
                sh 'pnpm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'pnpm run test'
            }
        }

        stage('Docker Build and Deploy') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                    ssh -o StrictHostKeyChecking=no ubuntu@<EC2-Public-IP> '
                        cd /home/ubuntu/cicd-pipeline &&
                        docker compose down &&
                        docker compose up -d --build
                    '
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
