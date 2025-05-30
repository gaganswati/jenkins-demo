pipeline {
    agent any
    environment {
        ACR_NAME = 'phpacr'
        IMAGE_NAME = 'php-app'
        IMAGE_TAG = 'v1'
        ACR_URL = "${ACR_NAME}.azurecr.io"
        RESOURCE_GROUP = 'php-app-rg'
        AKS_CLUSTER = 'phpaks'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://your-repo-url.com/php-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
                sh 'docker tag $IMAGE_NAME $ACR_URL/$IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Push to ACR') {
            steps {
                sh "az acr login --name $ACR_NAME"
                sh 'docker push $ACR_URL/$IMAGE_NAME:$IMAGE_TAG'
            }
        }

        stage('Deploy to AKS') {
            steps {
                sh "az aks get-credentials --resource-group $RESOURCE_GROUP --name $AKS_CLUSTER"
                sh 'kubectl apply -f k8s/php-deployment.yaml'
                sh 'kubectl apply -f k8s/php-service.yaml'
            }
        }
    }
}
