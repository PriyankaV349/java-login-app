pipeline{
  agent any
    environment {
      PATH = "$PATH:/usr/share/maven/bin"
    }
    stages {      
      stage('Build') {
        steps{
          sh '"mvn" -Dmaven.test.failure.ignore clean install'
        }
      }
      
      stage('SonarQube analysis') {
        steps {
          withSonarQubeEnv('sonarqube-8.9.1.44547') { 
            sh "mvn sonar:sonar"
          }
        }
      }
      
      stage ('Deploy') {
        steps {
          script {
            deploy adapters: [tomcat9(path: '', url: 'http://65.0.109.114:8080/')], contextPath: null, onFailure: false, war: '**/*.war'
          }
        }
      }
    }
}  
