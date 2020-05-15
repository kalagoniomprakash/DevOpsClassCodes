pipeline{
    tools {
      jdk 'JAVA_HOME'
      git 'mygit'
      maven 'myMaven'
    }
    agent none
    triggers { upstream(upstreamProjects: 'compile,unitTest,codereview,codereviewSonarQube,metricCheck,package', threshold: hudson.model.Result.SUCCESS) }
    stages{
        stage('checkout'){
            agent any
            steps{
                git 'https://github.com/kalagoniomprakash/DevOpsClassCodes.git'
            }
            
        }
        stage('compile'){
            agent any
            steps{
                sh 'mvn compile'
                
            }
            
        }
        stage('codereview'){
            agent any
            steps{
                sh 'mvn pmd:pmd'
            }
            post
            {
                success{
                    pmd pattern: 'target/pmd.xml'
                }
            }
            
        }
        stage('codereviewSonarQube'){
            agent {label 'Linux_SonarQube'}
            steps{
                withSonarQubeEnv('mySonar'){
                    git 'https://github.com/kalagoniomprakash/DevOpsClassCodes.git'
                    sh 'mvn compile'
                    sh 'mvn sonar:sonar' 
                }
               
            }
            
        }
        stage('unitTest'){
           agent {label 'Linux_Slave'}
            steps{
                git 'https://github.com/kalagoniomprakash/DevOpsClassCodes.git'
                sh 'mvn test'
                
            }
            post{
                success{
                    junit 'target/surefire-reports/*.xml'
                }
                
            }
            
        }
         stage('metricCheck'){
           agent {label 'Linux_Centos_Slave'}
            steps{
                git 'https://github.com/kalagoniomprakash/DevOpsClassCodes.git'
                sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
                
            }
            post{
                success{
                    cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml '
                }
                
            }
            
        }
         stage('package'){
           agent any
            steps{
                
                sh 'mvn package'
                
            }
            
            
        }
    }
}
