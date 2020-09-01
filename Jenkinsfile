pipeline {
  agent any

  stages {
    stage ('Clone project from git') {
      steps {
        git 'https://github.com/Galend-E/DevOps_HW_final.git'
        sh 'sed -i s/docker_password/$pass/g ./build/build.yml'
      }
    }
    stage ('Create build instance; build and push docker image') {
      steps {
        sh 'cd build'
        sh 'terraform init'
        sh 'terraform plan -out build.tfplan'
        sh 'terraform apply -auto-approve'
      }
    }
    stage ('Create web instance; pull and run docker image') {
      steps {
        sh 'cd ../web'
        sh 'terraform init'
        sh 'terraform plan -out web.tfplan'
        sh 'terraform apply -auto-approve'
      }
    }
  }
}