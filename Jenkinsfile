// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any
  environment {
    PATH = '${PATH}:/bin:/usr/bin' // Environment for PATH must be set until Jenkins resolves: https://issues.jenkins-ci.org/browse/JENKINS-41339
    SWARM_TEST = 'docker -H localhost:2374' // SSH tunnel to one of the Swarm test Manager nodes.
    SWARM_PROD = '' // SSH tunnel to one of the Swarm test Manager nodes.
    DOCKER_REPO = 'angelcam'
    APP = 'developer-docs'
    STACK = "${APP}"
    }

  stages {

    stage('Build docker image') {
      steps {
        sh 'docker build -t $DOCKER_REPO/$APP:$(git rev-parse HEAD) .'
    }}

    stage('Inspect image') {
      steps {
        sh 'docker inspect $DOCKER_REPO/$APP:$(git rev-parse HEAD)'
    }}

    stage('Publish image to Docker Repository') {
      steps {
        sh 'docker push $DOCKER_REPO/$APP:$(git rev-parse HEAD)'
    }}

    stage('Deploy stack to Swarm test') {
      when { branch 'develop' }
        steps {
          sh '''
	     export TAG=$(git rev-parse HEAD)
	     ${SWARM_TEST} stack deploy --prune -c ci/deploy/develop-stack.yml ${STACK}
	     '''
    }}
    stage('Deploy stack to Swarm production?') {
      when { branch 'master' }
        steps {
          sh 'echo "I will be big boy one day and i will deploy to production then"'
     }}}}
