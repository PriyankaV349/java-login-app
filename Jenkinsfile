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
         deploy adapters: [tomcat8(credentialsId: 'Jenkins-Slave-1', path: '', url: 'http://34.226.210.244:8080')], contextPath: null, war: '**/**.war'
      }
    }
  }
}
