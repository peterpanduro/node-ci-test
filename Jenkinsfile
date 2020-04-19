pipeline {
    agent {
        dockerfile {
            filename 'jenkinsAgent.Dockerfile'
            additionalBuildArgs  '--build-arg JENKINSUID=`id -u jenkins` --build-arg JENKINSGID=`id -g jenkins` --build-arg DOCKERGID=`stat -c %g /var/run/docker.sock`'
            args '-v /var/run/docker.sock:/var/run/docker.sock -u jenkins:docker'
        }
    }
    environment { 
        CI = 'true'
        HOME = '.'
        registry = "kodifiera/node-ci-test"
        registryCredential = 'docker-hub-credentials'
        dockerImage = ''
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