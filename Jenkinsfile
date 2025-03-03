pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vikask0199/vikask0199-cicd-ec2-github-docker-jenkins.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install -g pnpm && pnpm install'
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

        stage('Docker Build') {
            steps {
                sh 'docker build -t cicd-pipeline:latest .'
            }
        }

        stage('Push to EC2 and Deploy') {
            steps {
                sshagent(['ec2-ssh-key']) {
                    sh '''
                    scp -o StrictHostKeyChecking=no docker-compose.yml ubuntu@54.224.163.249:/home/ubuntu/cicd-pipeline/
                    ssh -o StrictHostKeyChecking=no ubuntu@54.224.163.249 '
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
