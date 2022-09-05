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
//    def scannerHome = tool 'SonarScanner 4.0';
        steps {
          withSonarQubeEnv('sonarqube-8.9.1') { 
        // If you have configured more than one global server connection, you can specify its name
//      sh "${scannerHome}/bin/sonar-scanner"
            sh "mvn sonar:sonar"
          }
        }
      }
      stage('Deploy') {
        steps {   
          deploy adapters: [tomcat8(credentialsId: 'Jenkins-Slave-1', path: '', url: 'http://52.201.248.170:8080')], contextPath: null, war: '**/**.war'
        }       
      }
    }
}   
