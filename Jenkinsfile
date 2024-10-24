pipeline {
    agent any
    environment {
        // Optionally, you can define any necessary environment variables here
        DOCKER_IMAGE = "saharheni/helloworld" // Base name for your Docker image
    }
    stages {
        stage('Start Pipeline') {
            steps {
                script {
                    checkout scm
                }
            }
        }
        stage('Cloning Code') {
            steps {
                script {
                    echo 'Building the Project...'
                    bat 'mvn clean package'
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('SonarQube_server') {
                        bat 'mvn sonar:sonar'
                    }
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Building Docker Image...'
                    dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo 'Pushing Docker Image to Docker Hub...'
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        dockerImage.push("${env.BUILD_ID}")
                        dockerImage.push("latest")
                    }
                }
            }
        }
        stage('Deploying App to Kubernetes') {
            steps {
                script {
                    echo 'Deploying to Kubernetes...'
                    kubernetesDeploy(configs: "Deployment.yaml", kubeconfigId: "kubernetes")
                }
            }
        }
    }
    post {
        always {
            echo 'Pipeline execution completed.'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
