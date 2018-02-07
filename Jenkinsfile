// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any
  environment {
    PATH = '${PATH}:/bin:/usr/bin:/usr/local/bin' // Environment for PATH must be set until Jenkins resolves: https://issues.jenkins-ci.org/browse/JENKINS-41339
    SSH_OPTS = '-oStrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa'
    GET_TEST_MANAGER = 'aws --profile describe-instances ec2 describe-instances --filters Name=tag:Name,Values=swarm-test-Manager --query=Reservations[0].Instances[0].PublicDnsName'
    GET_PROD_MANAGER = 'aws --profile describe-instances ec2 describe-instances --filters Name=tag:Name,Values=swarm-prod-Manager --query=Reservations[0].Instances[0].PublicDnsName'
    SWARM_TEST = "ssh ${SSH_OPTS} docker@\$(${SWARM_TEST_MANAGER}) docker"
    SWARM_PROD = '' // SSH tunnel to one of the Swarm test Manager nodes.
    DOCKER_REPO = 'angelcam'
    APP = 'developer-docs'
    STACK = "${APP}"
    }

  stages {

    stage('Build docker image') {
      steps {
      	sh 'export testujeme="prase"'
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
	     echo $testujeme
	     export TAG=$(git rev-parse HEAD)
#	     export SWARM_TEST_MANAGER=$(${GET_TEST_MANAGER})
#	     export SWARM_TEST="ssh ${SSH_OPTS} docker@${SWARM_TEST_MANAGER} docker"
	     ${SWARM_TEST} stack deploy --prune -c ci/deploy/develop-stack.yml ${STACK}
	     '''
    }}
    stage('Deploy stack to Swarm production?') {
      when { branch 'master' }
        steps {
          sh 'echo "I will be big boy one day and i will deploy to production then"'
     }}}}
