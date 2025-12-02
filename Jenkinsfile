pipeline {
    agent any

    environment {
        TF_VAR_region = "us-east-1"
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                withCredentials([aws(credentialsId: 'aws-js-ps', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                    terraform init
                    """
                }
            }
        }

        stage('Plan') {
            steps {
                withCredentials([aws(credentialsId: 'aws-js-ps', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                    terraform plan -out=tfplan
                    """
                }
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
                withCredentials([aws(credentialsId: 'aws-js-ps', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh """
                    terraform apply -auto-approve tfplan
                    """
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
