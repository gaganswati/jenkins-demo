pipeline {
    agent any

    environment {
        // AWS ECR details
        AWS_REGION = 'us-west-2'         // Adjust the AWS region
        ECR_REPOSITORY = 'my-php-app' // Your ECR repository name
        IMAGE_TAG = "${env.BUILD_ID}"    // Image tag (e.g., Jenkins build ID)
        AWS_ACCOUNT_ID = '381492277936'  // aws account
        AWS_CREDENTIALS = 'aws-credentials' // Jenkins AWS credentials
    }

    stages {
        stage('Checkout') {
            steps {
               git 'https://github.com/gaganswati/jenkins-demo.git'
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

        stage('Deploy to ECS') {
            steps {
                script {
                    // Trigger ECS deployment (optional based on your setup)
                    // You may use AWS CLI, ECS SDK, or other tools for this
                    sh '''
                        aws ecs update-service --cluster php-app-clusteer --service php-01-service --force-new-deployment --region $AWS_REGION
                    '''
                }
            }
        }
    }
}
