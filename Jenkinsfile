pipeline {
    agent {
        label 'container'
    }


    parameters {
        string(name: "TAG", description: "Commit hash of the latest git commit")
    }


    stages {
        stage('Checkout SCM') {
            steps {
                checkout scmGit(
                    branches: [[name: '*/main']],
                    userRemoteConfigs: [
                        [credentialsId: 'github-ssh-key', url: 'https://github.com/Mys7erio/ali.viation-manifests']
                    ]
                )
            }
        }
        
        stage('Configure git and clone repository') {
            steps {
                sh "git config --global user.name ${GITUSER_NAME}"
                sh "git config --global user.email ${GITUSER_EMAIL}"
                sh "git config -l"
                sh "git checkout main && git branch"
            }
        }

        stage('Modify deployment version') {
            steps {
                sh "echo ${env.TAG}"
                sh "bash update-manifest.sh ${env.TAG}"
                sh "cat 1-deployment.yaml"
            }
        }

        stage('Push updated manifests') {
            steps {
                sshagent(['github-ssh-key']) {
                    
                    sh "git add ."
                    sh "git commit -m '[AUTOMATED]: Updated deployment to version: ${env.TAG}'"
                    
                    // Add github's public to known_hosts, and push
                    sh "ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts"
                    sh "git push git@github.com:Mys7erio/ali.viation-manifests.git"
                }
            }
        }
    }
}