pipeline {
  agent any
  environment {
    AWS_ACCOUNT_ID="022766710761"
    AWS_DEFAULT_REGION="us-east-1" 
    IMAGE_REPO_NAME="jenkins-pipeline-build-demo"
    IMAGE_TAG="latest"
    REPOSITORY_URI = "022766710761.dkr.ecr.us-east-1.amazonaws.com/jenkins-pipeline-build-demo"
	PATH = "$PATH:/usr/share/maven/bin"
  }
   
  stages {
      
    stage('Login to AWS ECR') {
      steps {
        script {
          sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 022766710761.dkr.ecr.us-east-1.amazonaws.com"
        }                
      }
    }
      
    stage('Build') {
      steps {
        sh '"mvn" -Dmaven.test.failure.ignore clean install' 
      }
    }
  
    // Building Docker images
    stage('Building Docker image') {
      steps {
        script {
          dockerImage = docker.build "jenkins-pipeline-build-demo:latest"
        }
      }
    }
   
    // Uploading Docker images into AWS ECR
    stage('Pushing image to ECR') {
      steps {  
        script {
          sh "docker tag jenkins-pipeline-build-demo:latest 022766710761.dkr.ecr.us-east-1.amazonaws.com/jenkins-pipeline-build-demo:latest"
          sh "docker push 022766710761.dkr.ecr.us-east-1.amazonaws.com/jenkins-pipeline-build-demo:latest"
        }
      }
    }
	  
    stage("Deploy to EKS") {
      steps {	  
	withKubeConfig(caCertificate: '', clusterName: 'jenkins-eks-cluster', contextName: '', credentialsId: 'K8S', namespace: '', serverUrl: '') {
          sh '''if /root/bin/kubectl get deploy | grep java-login-app
                then
                /root/bin/kubectl set image deployment jenkins-pipeline-build-demo java-app=022766710761.dkr.ecr.us-east-1.amazonaws.com/jenkins-pipeline-build-demo:latest
                /root/bin/kubectl rollout restart deployment java-login-app
                else
                /root/bin/kubectl apply -f deployment.yaml
                fi'''
	}			
      }
    }
    
    stage("Wait for Deployments") {
      steps {
        timeout(time: 2, unit: 'MINUTES') {
          sh '/var/lib/jenkins/bin/kubectl get svc'
        }
      }
    }  
  }
}
