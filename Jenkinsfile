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
         deploy adapters: [tomcat9(credentialsId: 'jenkins', path: '', url: 'http://54.159.181.173:8080')], contextPath: null, war: '**/**.war'
      }
    }
  }
}
