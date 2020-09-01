pipeline {
  agent any

  stages {
    stage ('Clone project from git') {
      steps {
        git 'https://github.com/Galend-E/DevOps_HW_final.git'
        sh 'sed -i s/docker_password/$pass/g build.yml'
      }
    }
    stage ('Create 2 instances; build and run docker image via registry') {
      steps {
        sh 'terraform init'
        sh 'terraform plan -out instances.tfplan'
        sh 'terraform apply -auto-approve'
      }
    }
  }
}