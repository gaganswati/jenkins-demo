pipeline {
    agent any
    environment {
        ACR_NAME = 'myphpacr'
        IMAGE_NAME = 'php-app'
        IMAGE_TAG = 'v1'
        ACR_URL = "${ACR_NAME}.azurecr.io"
        RESOURCE_GROUP = 'myResourceGroup'
        AKS_CLUSTER = 'myAKSCluster'
        GIT_CREDENTIALS = credentials('GitAuthToken')
        PATH = '/usr/local/bin:$PATH'
        SHELL = '/bin/bash'
    }

    stages {
        stage('Checkout') {
            steps {
                 git branch: 'main', 
                     credentialsId: 'GitAuthToken',
                     url: 'https://github.com/gaganswati/jenkins-demo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                 withEnv([
                     "PATH+EXTRA=/usr/local/bin:/bin:/usr/bin",
                     "DOCKER_BUILDKIT=1"
                ]){
                    sh 'docker build -t $IMAGE_NAME .'
                    sh 'docker tag $IMAGE_NAME $ACR_URL/$IMAGE_NAME:$IMAGE_TAG'
                }    
            }
        }
        stage('Push to ACR') {
            steps {
                   withEnv(["PATH=/opt/homebrew/bin:$PATH"]) {
                    sh '''
                        az acr login --name ${ACR_NAME}
                        docker push ${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG}
                    '''
                   }    
               }
          }
        stage('Deploy to AKS') {
            steps {
                    withEnv(["PATH=/opt/homebrew/bin:$PATH"]) {
                    sh 'az aks get-credentials --resource-group ${RESOURCE_GROUP} --name ${AKS_CLUSTER}'
                    sh 'kubectl apply -f deployment.yaml'
                    sh 'kubectl apply -f service.yaml'
                }
            }
        }
    }
}
