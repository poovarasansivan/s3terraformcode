pipeline {
    agent any
    
    options {
        timestamps()
        ansiColor('xterm')
    }

    environment {
        TF_VAR_region = "us-east-1"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
                echo "Branch: ${env.BRANCH_NAME}"
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-js-ps', region: "us-east-1") {
                    sh "terraform init -upgrade"
                }
                echo "Terraform init completed"
            }
        }

        stage('Terraform Validate') {
            steps {
                sh "terraform validate"
                echo "Code validation successful"
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-js-ps', region: "us-east-1") {
                    sh "terraform plan -out=tfplan"
                }
                echo "Terraform plan generated"
            }
        }

        stage('Approval Before Apply') {
            when {
                branch 'main'
            }
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: "Approve Apply to AWS?"
                }
            }
        }

        stage('Terraform Apply') {
            when {
                branch 'main'
            }
            steps {
                withAWS(credentials: 'aws-js-ps', region: "us-east-1") {
                    sh "terraform apply -auto-approve tfplan"
                }
                echo "Terraform Apply Done!"
            }
        }
    }

    post {
        success {
            echo "Terraform Pipeline Execution Successful!"
        }
        failure {
            echo "Terraform Pipeline Failed!"
        }
    }
}
