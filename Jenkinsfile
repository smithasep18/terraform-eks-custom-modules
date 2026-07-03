pipeline {
    agent any

    parameters {
        choice(
            name: 'ACTION',
            choices: ['plan', 'apply', 'destroy'],
            description: 'Select Terraform action'
        )
    }

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/smithasep18/terraform-eks-custom-modules.git'
            }
        }

        stage('Tool Versions') {
            steps {
                sh 'terraform version'
                sh 'aws --version'
                sh 'aws sts get-caller-identity'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            when {
                expression { params.ACTION != 'destroy' }
            }
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            when {
                expression { params.ACTION == 'plan' || params.ACTION == 'apply' }
            }
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Manual Approval for Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                input message: 'Proceed with terraform apply to create custom-module EKS cluster?'
            }
        }

        stage('Terraform Apply') {
            when {
                expression { params.ACTION == 'apply' }
            }
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }

        stage('Manual Approval for Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                input message: 'Proceed with terraform destroy to delete custom-module EKS cluster?'
            }
        }

        stage('Terraform Destroy') {
            when {
                expression { params.ACTION == 'destroy' }
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}