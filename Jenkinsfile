pipeline {
    agent any

    options {
        ansiColor('xterm')
    }
    
    environment {
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
        AWS_DEFAULT_REGION = 'us-east-1'

        TF_VAR_cloud_backend_bucket = 'kavala13-terraform'
        TF_VAR_cloud_backend_key = 'vertica-cloud'
        TF_VAR_cloud_backend_region = 'us-east-1'

        TF_VAR_db_user = 'dbadmin'
        TF_VAR_db_name = 'db1'
        TF_VAR_db_password = 'admin'
        TF_VAR_db_port = '5433'
        TF_VAR_db_communal_storage = 's3://kavala13-vertica/storage'
        TF_VAR_ssh_key_path = credentials('ssh-public-key')
    }    

    stages {
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying..'
                sh './01_deploy.sh'
            }
        }
        stage('Configure') {
            steps {
                echo "Configuring"
            }
        }
    }
}

