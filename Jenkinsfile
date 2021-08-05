pipeline {
    environment {
        GIT_COMMIT = ''
        REGISTRY = 'my-docker-registry'
    }
    agent any
    stages {
        stage ('checkout') {
            steps {
                script {
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github-herreraluis', url: 'https://github.com/herrera-luis/aws-cloudformation-eks']]])
                }
            }
        }

        stage ('Build') {
            steps {
                script {
                    gitCommitHash = sh (script: 'git rev-parse --short HEAD', returnStdout: true)
                    withDockerRegistry([credentialsId: 'dockerhub', url: 'https://index.docker.io/v1/']) {
                        image = docker.build("herreraluis/basic_example:${gitCommitHash} -f api/Dockerfile .")
                        image.push()
                    }
                }
            }
        }
    //   stage ('K8S Deploy') {
    //     kubernetesDeploy(
    //         configs: 'k8s/2_app-v1.yaml',
    //         kubeconfigId: 'K8S',
    //         enableConfigSubstitution: true
    //         )
    //     }
    }
}
