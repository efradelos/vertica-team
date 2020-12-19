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
                    echo 'Configuring....'
                    pwd
                    ls -al
                    cd "$WORKSPACE"
                    ls -al
                '''
            }
        }
    }
}