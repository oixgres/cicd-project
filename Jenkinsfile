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
            '''
        }
    }
    stages{
        stage('Build'){
            steps{
                container ('docker')  {
                    sh 'dockerd & > /dev/null'
                    sleep(time: 10, unit: "SECONDS")
                    sh 'docker buildx build --network=host --platform=linux/amd64 --tag="211125306454.dkr.ecr.us-east-1.amazonaws.com/test" -f Dockerfile .'
                }
            }
        }
        stage('Publish'){
            steps{
                container ('docker')  {
                    sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 211125306454.dkr.ecr.us-east-1.amazonaws.com'
                    sh 'docker push "211125306454.dkr.ecr.us-east-1.amazonaws.com/test"'
                    
                }
            }
        }
    }

}