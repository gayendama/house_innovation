/*
prérequis: 
1) configurer une variable "DOCKER_PASSWORD" dans les paramêtres du serveur jenkins
2) configurer les "notifications par email" sur le serveur jenkins, mois j'ai utilisé "gmail.com"
3) installer "trivy" sur le serveur jenkins 
*/
def PROJET = "Test House innovation"
def ID_DOCKER = "ndamagaye"
def IMAGE_NAME = "house-innovation"
def IMAGE_TAG = "latest"
def PortApp = 80
def PortContainer = 8200

pipeline{
    agent any
    environment {
        DOCKER_PASSWORD = credentials('DOCKER_PASSWORD')
    }
    stages {
    stage('Build Docker Image'){
        steps{
            script{
                sh "docker build -t ${ID_DOCKER}/${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
    }

    stage('Test acceptance'){
        steps{
            script{
                
                sh "docker run --name ${IMAGE_NAME} -d -p ${PortContainer}:${PortApp} ${IMAGE_NAME}:${IMAGE_TAG}"
                sh "curl localhost:${PortContainer} | grep -q 'Author: Roody95'"
                sh "docker stop ${IMAGE_NAME}"
                sh "docker rm ${IMAGE_NAME}"

            }
        }
    }
stage('Push Image sur DockerHub') {
            steps {
                script {
                      // Login to Docker Hub
                    sh '''
                        echo Sokhn@diaw | docker login -u ${ID_DOCKER} --password-stdin
                    '''

                    // Pousser l'image sur Docker Hub
                    sh "docker push ${ID_DOCKER}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    stage('scan vulnerabilte image'){
        steps{
            script{
                sh "trivy image --no-progress --exit-code 1 --severity HIGH ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
    }
     

    
}
}
    

