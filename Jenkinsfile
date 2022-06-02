pipeline {
    agent { dockerfile true }
   
    environment {
        DATE = new Date().format('yy.M')
        TAG = "${DATE}.${BUILD_NUMBER}"
    }
    stages {
        stage ('Build') {
            agent {
                docker {
                    image 'node:12.18-alpine'
                }
            }
            steps {
                script {
                    docker.build("registry.gitlab.com/tinhchieuphuoc/cicd-automation-test:${TAG}")
                }
            }
        }
        stage('Pushing Docker Image to gitlab') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_credential') {
                        docker.image("vigneshsweekaran/hello-world:${TAG}").push()
                        docker.image("vigneshsweekaran/hello-world:${TAG}").push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                sh "docker stop hello-world | true"
                sh "docker rm hello-world | true"
                sh "docker run --name hello-world -d -p 9004:8080 vigneshsweekaran/hello-world:${TAG}"
            }
        }
    }
}