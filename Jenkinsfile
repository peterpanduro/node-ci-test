pipeline {
    agent {
        docker {
            image 'node:12-alpine'
            args '-p 3000:3000'
        }
    }
    environment { 
        CI = 'true'
        registry = "kodifiera/node-ci-test"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm cache clean -f'
                sh 'rm -rf node_modules package-lock.json'
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm test'
            }
        }
        stage('Staging') { 
            steps {
                sh 'npm run build'
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deliver') {
            steps {
                input message: 'Publish?'
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}