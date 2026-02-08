pipeline {
    agent any
    
    environment {
        TF_VERSION = '1.6.0'
        AWS_REGION = 'us-east-1'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Code checked out from SCM'
                sh 'ls -la'
            }
        }
        
        stage('Terraform Format Check') {
            steps {
                script {
                    def formatResult = sh(script: 'terraform fmt -check -recursive', returnStatus: true)
                    if (formatResult != 0) {
                        unstable(message: "Terraform formatting issues found")
                    }
                }
            }
        }
        
        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend=false'
            }
        }
        
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        
        stage('Terraform Plan') {
            steps {
                withCredentials([
                    string(credentialsId: 'db-password', variable: 'DB_PASSWORD'),
                    string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
                    string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
                ]) {
                    sh '''
                        terraform plan \
                        -var="db_password=${DB_PASSWORD}" \
                        -out=tfplan \
                        -no-color | tee plan.txt
                    '''
                }
            }
        }
        
        stage('Archive Plan') {
            steps {
                archiveArtifacts artifacts: 'plan.txt', fingerprint: true
            }
        }
    }
    
    post {
        success {
            echo '✅ Pipeline completed successfully!'
        }
        failure {
            echo '❌ Pipeline failed!'
        }
        always {
            cleanWs()
        }
    }
}
