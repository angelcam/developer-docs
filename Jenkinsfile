// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any

  options {
    ansiColor('xterm')
  }

  environment {
    PATH = '${PATH}:/bin:/usr/bin:/usr/local/bin' // Environment for PATH must be set until Jenkins resolves: https://issues.jenkins-ci.org/browse/JENKINS-41339
    SSH_OPTS = '-oStrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa'
    GET_TEST_MANAGER = 'aws --output text --profile describe-instances ec2 describe-instances --filters Name=tag:Name,Values=swarm-test-Manager --query=Reservations[0].Instances[0].PublicDnsName'
    GET_PROD_MANAGER = 'aws --output text --profile describe-instances ec2 describe-instances --filters Name=tag:Name,Values=swarm-prod-Manager --query=Reservations[0].Instances[0].PublicDnsName'
    SWARM_TEST = "docker -H localhost:2374"
    SWARM_PROD = '' // SSH tunnel to one of the Swarm test Manager nodes.
    DOCKER_REPO = 'angelcam'
    APP = 'developer-docs'
    STACK = "${APP}"
    }

  stages {

    stage('Build, inspect and push (commit, develop) docker image') {
      steps {
        sh '''
        docker build -t $DOCKER_REPO/$APP:${GIT_COMMIT} -t $DOCKER_REPO/$APP:develop .
        docker inspect $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:${GIT_COMMIT}
        docker push $DOCKER_REPO/$APP:develop
        '''
    }}

    stage('Deploy stack to Swarm test') {
      when { branch 'develop' }
        steps {
          sh '''
             #!/bin/sh
             export TAG=$(git rev-parse HEAD)

             deploy_stack() {
               ${SWARM_TEST} stack deploy --prune -c ci/deploy/develop-stack.yml ${STACK} \
               && echo "Stack deployed to Swarm test"
             }

             check_stack() {
               for service in $(${SWARM_TEST} stack services --format '{{ .Name }}' ${STACK})
                do ${SWARM_TEST} service update -q ${service} \
                && echo "Services seems in good mood."
               done
             }

             if ${SWARM_TEST} node ls
             then
              echo "Swarm works, Let's deploy Stack!"
              deploy_stack
              check_stack
             else
              echo "Creating tunnel"
              ssh -f ${SSH_OPTS} docker@\$(${GET_TEST_MANAGER}) -NL localhost:2374:/var/run/docker.sock
              deploy_stack
              check_stack
             fi
            '''
    }}
    stage('Deploy stack to Docker production?') {
      when { branch 'master' }
        steps {
          ansiblePlaybook(
            inventory: 'ci/deploy/prod',
            playbook: 'ci/deploy/deploy.yml'
          )
     }}}}
