pipeline{
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                  containers:
                  - name: docker
                    image: docker:latest
                    command:
                    - cat
                    tty: true
                    securityContext:
                      privileged: true
                    volumeMounts:
                    - mountPath: /var/run/docker.sock
                      name: docker-sock
                  volumes:
                  - name: docker-sock
                    hostPath:
                      path: /var/run/docker.sock
            '''
        }
    }
    stages{
        stage('Build'){
            steps{
                container ('docker')  {
                    sh 'dockerd & > /dev/null'
                    sleep(time: 10, unit: "SECONDS")
                    sh 'docker buildx build --network=host --platform=linux/amd64 --tag="533267333644.dkr.ecr.us-east-1.amazonaws.com/test" -f Dockerfile .'
                }
            }
        }
        stage('Publish'){
            steps{
                container ('docker')  {
                    sh """#!/bin/bash
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 533267333644.dkr.ecr.us-east-1.amazonaws.com
                    docker push "533267333644.dkr.ecr.us-east-1.amazonaws.com/test"
                    """
                }
            }
        }
    }

}