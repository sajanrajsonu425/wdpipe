pipeline {
agent any
  environment {
    AWS_ACCOUNT_ID="581837793822"
    AWS_DEFAULT_REGION="us-east-1"
    IMAGE_REPO_NAME="wdpipe"
    IMAGE_TAG="latest"
    REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
  }
  stages {
    stage("Logging into AWS ECR") {
      steps {
        script {
          bat"aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
        }
      }
    }
    stage("Cloning Git") {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '', url: 'https://github.com/sajanrajsonu425/wdpipe.git']]])
      }
    }

// Building Docker images
    stage("Building image") {
      steps{
        script {
          bat "docker build -t wdpipe ."
        }
      }
    }

// Uploading Docker images into AWS ECR
    stage("Pushing to ECR") {
      steps{
        script {
          bat "docker tag ${IMAGE_REPO_NAME}:${IMAGE_TAG} ${REPOSITORY_URI}:${IMAGE_TAG}"
          bat "docker push ${REPOSITORY_URI}:${IMAGE_TAG}"
        }
      }
    }
  }
}
