pipeline{
    agent any
    tools{
        docker 'latest'
    }
    stages{
        stage('Build'){
            steps{
                sh """#!/bin/bash
                echo "Building branch: $env.GIT_BRANCH"

                docker buildx build --network=host --platform=linux/amd64 --tag="533267333644.dkr.ecr.us-east-1.amazonaws.com/test"
                """
            }
        }
        stage('Publish'){
            steps{
                sh """#!/bin/bash
                aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 533267333644.dkr.ecr.us-east-1.amazonaws.com
                docker push "533267333644.dkr.ecr.us-east-1.amazonaws.com/test"
                """
            }
        }
    }

}