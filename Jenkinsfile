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
                sh 'export TEST_ENV=development'
                echo 'Deploying..'
            }
        }
        stage('Configure') {
            steps {
                sh '''
                    echo "Maybe: $TEST_ENV"
                '''
            }
        }
    }
}