pipeline {
    agent any

    environment {
        TF_VAR_region = "us-east-1"
        AWS_CREDENTIALS = credentials('aws-js-ps')
    }

    stages {

        stage('Terraform Init') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_CREDENTIALS_USR
                export AWS_SECRET_ACCESS_KEY=$AWS_CREDENTIALS_PSW
                terraform init
                '''
            }
        }

        stage('Plan') {
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_CREDENTIALS_USR
                export AWS_SECRET_ACCESS_KEY=$AWS_CREDENTIALS_PSW
                terraform plan -out=tfplan
                '''
            }
        }

        stage('Approval') {
            when {
                branch 'main'
            }
            steps {
                input message: "Approve deployment to PRODUCTION?"
            }
        }

        stage('Apply') {
            when {
                branch 'main'
            }
            steps {
                sh '''
                export AWS_ACCESS_KEY_ID=$AWS_CREDENTIALS_USR
                export AWS_SECRET_ACCESS_KEY=$AWS_CREDENTIALS_PSW
                terraform apply -auto-approve tfplan
                '''
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
