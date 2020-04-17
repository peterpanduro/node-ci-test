pipeline {
    def app
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
                app = docker.build("kodifiera/node-ci-test")
            }
        }
        stage('Deliver') {
            steps {
                input message: 'Publish?'
                docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                }
            }
        }
    }
}