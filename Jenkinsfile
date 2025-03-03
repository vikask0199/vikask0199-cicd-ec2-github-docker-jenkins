pipeline {
    agent any

    environment {
        NODE_ENV = 'production'
        NVM_DIR = '/home/ubuntu/.nvm'  // Add this line to specify the NVM directory
        NODE_VERSION = 'v22.14.0'      // Specify the installed Node.js version here
    }


    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/vikask0199/vikask0199-cicd-ec2-github-docker-jenkins.git'
            }
        }


        stage('Install Dependencies') {
            steps {
                script {
                    // Load NVM and Node version
                    sh '''
                    source ~/.nvm/nvm.sh
                    nvm install $NODE_VERSION
                    nvm use $NODE_VERSION
                    npm install
                    '''
                }
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'npm run test'
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
