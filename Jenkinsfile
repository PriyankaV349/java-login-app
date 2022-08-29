pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh '"mvn" -Dmaven.test.failure.ignore clean install'
      }
    }
    stage('Deploy') {
      steps {   
         deploy adapters: [tomcat9(credentialsId: 'tomcat-credentials', url: "${tomcatServerUrl}")], contextPath: 'pipeline-java-app', war: '**/*.war'
      }
    }
  }
}
