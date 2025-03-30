pipeline {
    agent any

    environment {
        // AWS ECR details
        AWS_REGION = 'us-west-2'         // Adjust the AWS region
        ECR_REPOSITORY = 'phpfirst_image' // Your ECR repository name
        $EKS_CLUSTER_NAME = 'first_eks_cluster'
        IMAGE_TAG = "${env.BUILD_ID}"    // Image tag (e.g., Jenkins build ID)
        AWS_ACCOUNT_ID = '149536456261'  // aws account
        AWS_CREDENTIALS = 'aws-credentials' // Jenkins AWS credentials
    }

    stages {
        stage('Checkout') {
            steps {
               git url: 'https://github.com/gaganswati/jenkins-demo.git' , branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image for the PHP application
                    sh '''
                        docker build -t $ECR_REPOSITORY:$IMAGE_TAG .
                    '''
                }
            }
        }

        stage('Login to ECR') {
            steps {
                script {
                    // Login to ECR using AWS CLI
                    withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: "$AWS_CREDENTIALS"]]) {
                        sh '''
                            aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                        '''
                    }
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    // Tag the image with the ECR repository URI and push it
                    sh '''
                        docker tag $ECR_REPOSITORY:$IMAGE_TAG $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG
                        docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:$IMAGE_TAG
                    '''
                }
            }
        }

        stage('Deploy to EkS') {
            steps {
                script {
                   
                    sh '''
                        aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME
                        kubectl set image deployment/my-php-app my-php-app=$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPOSITORY:latest
                    '''
                }
            }
        }
    }
}
