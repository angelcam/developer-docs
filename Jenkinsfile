// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any

  options {
    ansiColor('xterm')
  }

  environment {
    PATH = '${PATH}:/bin:/usr/bin:/usr/local/bin' // Environment for PATH must be set until Jenkins resolves: https://issues.jenkins-ci.org/browse/JENKINS-41339
    DOCKER_REPO = 'angelcam'
    APP = 'developer-docs'
    }

  stages {

    stage('Build, inspect and push (commit, develop) docker image') {
      steps {
        when { branch 'develop' }
        sh '''
        docker build -t $DOCKER_REPO/$APP:${GIT_COMMIT} -t $DOCKER_REPO/$APP:develop .
        docker inspect $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:develop
        '''
    }}

    stage('Build, inspect and push (commit, latest) docker image') {
      steps {
        when { branch 'master' }
        sh '''
        docker build -t $DOCKER_REPO/$APP:${GIT_COMMIT} -t $DOCKER_REPO/$APP:latest .
        docker inspect $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:latest
        '''
    }}

    stage('Deploy stack to Swarm test') {
      when { branch 'develop' }
        steps {
            ansiblePlaybook(
              inventory: 'ci/deploy/inventory/test',
              playbook: 'ci/deploy/deploy.yml'
            )
    }}
    stage('Deploy stack to Docker production?') {
      when { branch 'master' }
        steps {
          ansiblePlaybook(
            inventory: 'ci/deploy/inventory/prod',
            playbook: 'ci/deploy/deploy.yml'
          )
     }}}}
