pipeline {
    agent any

    environment {
        GOOGLE_CREDENTIALS = credentials('gcloud')  // Jenkins credential ID for GCP
        TFVARS_FILE = "${APPLICATION_NAME}.tfvars"
    }
    
    parameters {
        choice(name: 'APPLICATION_NAME', choices: ['cloudstorage', 'app2'], description: 'Select application environment')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Setup GCP Auth') {
            steps {
                script {
                    bat 'echo %GOOGLE_CREDENTIALS% > smooth-league-275317-eafc1a750e38.json'
                }
            }
        }

        stage('Terraform Actions') {
            steps {
                withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${WORKSPACE}\\smooth-league-275317-eafc1a750e38.json"]) {
                    bat 'terraform init -no-color'
                    bat 'terraform validate -no-color'
                    bat "terraform plan -var-file=${TFVARS_FILE} -out=tfplan -no-color"
                }
            }
        }

        stage('Review Plan') {
            steps {
                input(message: 'Review the Terraform plan. Proceed to apply?', ok: 'Proceed')
            }
        }

        stage('Terraform Apply') {
            steps {
                withEnv(["GOOGLE_APPLICATION_CREDENTIALS=${WORKSPACE}\\smooth-league-275317-eafc1a750e38.json"]) {
                    bat "terraform apply -auto-approve tfplan"
                }
            }
        }
    }

    post {
        always {
            bat 'del smooth-league-275317-eafc1a750e38.json'
        }
    }
}
