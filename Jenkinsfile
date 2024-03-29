pipeline {
    agent any
    parameters {
        string(name: 'web-str', defaultValue: "I am node ", description: 'web server index.html content')
    }
    stages {
        stage('checkout code') {
            steps {
                git(url: 'http://github.com/ilan', credentialsId: 'jenkinsuser', branch: master)
            }
        }
        stage('Creating an ECR repository') {
            steps {
                sh '''
                   cd ecr_iac
                   terraform init
                   terraform plan -auto-approve
                   terraform apply -auto-approve
                '''
            }
        }
        stage('Building web Docker image') {
            steps {
                sh '''
                  docker build -t web-image .
                  aws ecr get-login-password --region region | docker login --username AWS --password-stdin 230417554355.dkr.ecr.region.amazonaws.com
                  docker tag web-image:latest 230417554355.dkr.ecr.region.amazonaws.com/web-image:latest
                  docker push aws_account_id.dkr.ecr.region.amazonaws.com/web-image:latest
                 '''
            }
        }
        stage('Create eks cluster') {
            steps {
                sh '''
                cd eks_iac
                terraform init
                terraform plan -auto-approve
                terraform apply -auto-approve
                '''
            }
        }
        stage('Deploy web app on eks') {
            steps {
                sh '''
                  cd k8s
                  kubectl apply -f deployment.yaml
                  kubectl apply -f web-service.yaml
                    '''
            }
        }
    }
}