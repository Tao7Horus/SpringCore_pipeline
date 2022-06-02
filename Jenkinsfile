pipeline {
    agent any
    tools {
        maven 'maven-3.6.3' 
    }
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
        stage('Docker Build') {
            steps {
                script {
		           docker login -u tinhchieuphuoc -p tao7horus registry.gitlab.com/tinhchieuphuoc/cicd-automation-test
                  docker pull registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest
  		         docker build --cache-from registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:latest --tag registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA .
  		 
                }
            }
        }
	    stage('Pushing Docker Image to Dockerhub') {
            steps {
                script {
                    docker push registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:$CI_COMMIT_SHA
                }
            }
        }
     }  
}