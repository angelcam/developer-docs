// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any
  environment {
    PATH = '${PATH}:/bin:/usr/bin' // Environment for PATH must be set until Jenkins resolves: https://issues.jenkins-ci.org/browse/JENKINS-41339
    SWARM_TEST = 'docker -H localhost:2374' // SSH tunnel to one of the Swarm test Manager nodes.
    SWARM_PROD = '' // SSH tunnel to one of the Swarm test Manager nodes.
    STACK = 'developer-docs'
    }

  stages {
    stage('Deploy stack to Swarm test') {
      when { branch 'develop' }
        steps {
          sh '${SWARM_TEST} stack deploy --prune -c stacks/develop-stack.yml ${STACK}'
    }}
    stage('Deploy stack to Swarm production?') {
      when { branch 'master' }
        steps {
          sh 'echo "I will be big boy one day and i will deploy to production then"'
     }}}}
