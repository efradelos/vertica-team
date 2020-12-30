pipeline {
    agent any

    options {
        ansiColor('xterm')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'

        TF_VAR_ssh_key_path = credentials('ssh-public-key')

    }    


    stages {
        stage('Test') {
            steps {
                echo 'Testing..'

            }
        }
        stage('Deploy to poc') {
            when { branch 'dev' }
            steps {
                echo 'Deploying..'
                sh './01_deploy.sh poc'
            }
        }
        stage('Deploy to sdlc...') {
            when { branch 'main' }
            steps {
                echo 'Deploying..'
                sh './01_deploy.sh sdlc'
            }
        }
        stage('Deploy to prod...') {
            when { tag pattern: "v\\d+\\.\\d+\\.\\d+", comparator: "REGEXP"}
            steps {
                echo 'Deploying..'
                sh './01_deploy.sh cust'
            }
        }
        stage('Configure') {
            steps {
                echo "Configuring"
            }
        }
    }
}

