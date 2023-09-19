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
                    sh 'echo $GOOGLE_CREDENTIALS > smooth-league-275317-eafc1a750e38.json'
                    // Set the environment variable that the Google provider plugin recognizes
                    sh 'export GOOGLE_APPLICATION_CREDENTIALS=${WORKSPACE}/smooth-league-275317-eafc1a750e38.json'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init'
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    // Auto-approve for demo purposes. In a real-world scenario, you might want manual approval
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            // Clean up. IMPORTANT: Make sure you handle state files securely and don't delete unless intended!
            sh 'rm -f gcp_key.json'
        }
    }
}
