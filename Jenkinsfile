pipeline {
    agent any

    stages {
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying..'
            }
        }
        stage('Configure') {
            steps {
                sh '''
                    ls -al
                    terraform help
                '''
            }
        }
    }
}