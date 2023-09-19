pipeline {
    agent any

    environment {
        GOOGLE_CREDENTIALS = credentials('gcloud')  // Jenkins credential ID for GCP
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
                    // Save the GCP service account key from Jenkins credentials to a file
                    bat 'echo %GOOGLE_CREDENTIALS% > smooth-league-275317-eafc1a750e38.json'
                    // On Windows, setting an environment variable this way may not work. 
                    // You might need to set this environment variable outside of the Jenkins pipeline, 
                    // or use a different method to authenticate with GCP.
                    bat 'set GOOGLE_APPLICATION_CREDENTIALS=%WORKSPACE%\\smooth-league-275317-eafc1a750e38.json'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                bat 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                bat 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                bat 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Auto-approve for demo purposes.
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            // Clean up. IMPORTANT: Make sure you handle state files securely and don't delete unless intended!
            bat 'del smooth-league-275317-eafc1a750e38.json'
        }
    }
}
