pipeline{
    agent any
    stages{
        stage('Build'){
            steps{                    
                    sh 'dockerd & > /dev/null'
                    sleep(time: 10, unit: "SECONDS")
                    sh 'docker buildx build --network=host --platform=linux/amd64 --tag="381492193208.dkr.ecr.us-east-1.amazonaws.com/test" -f Dockerfile .'
                }
            }
        stage('Publish'){
            steps{
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381492193208.dkr.ecr.us-east-1.amazonaws.com'
                sh 'docker push "381492193208.dkr.ecr.us-east-1.amazonaws.com/test"'
            }
        }
        stage("Deploy"){
            steps{
                sh 'kubectl rollout restart deployment test'
            }
        }
    }

}