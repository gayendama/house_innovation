/*
prérequis: 
1) configurer une variable "DOCKER_PASSWORD" dans les paramêtres du serveur jenkins
2) configurer les "notifications par email" sur le serveur jenkins, mois j'ai utilisé "gmail.com"
3) installer "trivy" sur le serveur jenkins 
*/
def PROJET = "Test House innovation"
def IMAGE_NAME = "house-innovation"
def IMAGE_TAG = "latest"
def PortApp = 80
def PortContainer = 8200

pipeline{
    agent any
  stages{

    /*stage('Clone Repository'){
        steps{
            git (branch: 'main', credentialsId: credential, url: repository)
        }
    }*/

    stage('Build Docker Image'){
        steps{
            script{
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
    }

    stage('Test acceptance'){
        steps{
            script{
                
                sh "docker run --name ${IMAGE_NAME}${BUILD_ID} -d -p ${PortContainer}:${PortApp} ${IMAGE_TAG}"
                sh "curl localhost:${PortContainer} | grep -q 'Author: Roody95'"
                sh "docker stop ${IMAGE_NAME}${BUILD_ID}"
                sh "docker rm ${IMAGE_NAME}${BUILD_ID}"

            }
        }
    }

    stage('scan vulnerabilte image'){
        steps{
            script{
                sh "trivy image --no-progress --exit-code 1 --severity HIGH ${IMAGE_TAG}"
            }
        }
    }
     

    
}
    
}
