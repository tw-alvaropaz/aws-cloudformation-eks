pipeline {
    environment {
        GIT_COMMIT = ""
        REGISTRY = "my-docker-registry"
    }
  agent any 
  stages {
    stage('checkout code') {
      steps {
      //  GIT_COMMIT_HASH = sh (script: "git rev-parse HEAD", returnStdout: true)
        script {
      // Checkout the repository and save the resulting metadata
      def scmVars = checkout([
        $class: 'GitSCM',
        ])

        // Display the variable using scmVars
        echo "scmVars.GIT_COMMIT"
        echo "${scmVars.GIT_COMMIT}"

        // Displaying the variables saving it as environment variable
        env.GIT_COMMIT = scmVars.GIT_COMMIT
        echo "env.GIT_COMMIT"
        echo "${env.GIT_COMMIT}"
        }
    }
      stage ('Build') {
         // Build and push image with Jenkins' docker-plugin
            withDockerRegistry([credentialsId: "dockerhub", url: "https://index.docker.io/v1/"]) {
            image = docker.build("herreraluis/basic_example", "${env.GIT_COMMIT}")
            image.push()    
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
