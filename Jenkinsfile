pipeline{
    agent any
    stages{
        stage('Build'){
            steps{
                    sh 'docker buildx build --network=host --platform=linux/amd64 --tag="211125306454.dkr.ecr.us-east-1.amazonaws.com/test" -f Dockerfile .'
                }
            }
        stage('Publish'){
            steps{
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 211125306454.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker push "211125306454.dkr.ecr.us-east-1.amazonaws.com/test"'
            }
        }
    }

}