pipeline {
    agent {
        label 'default'
    }


    // parameters {
    //     string(name: TAG, description="Latest dockerimage tag")
    // }


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

        stage('Modify deployment version') {
            steps {
                sh "echo ${env.TAG}"
                sh "./update-manifest.sh ${env.TAG}"
                sh "cat 1-deployment.yaml"
            }
        }
    }
}