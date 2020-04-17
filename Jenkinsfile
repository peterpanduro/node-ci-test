pipeline {
    agent {
        docker {
            image 'node:12-alpine'
            args '-p 3000:3000'
        }
    }
    environment { 
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
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
                sh 'docker build ./build -t kodifiera/node-ci-test'
                sh 'docker run -p 3000:3000 -d kodifiera/node-ci-test'
            }
        }
        stage('Deliver') {
            steps {
                input message: 'Publish?'
                sh 'echo THIS SHOULD PUBLISH TO DOCKERHUB'
            }
        }
    }
}