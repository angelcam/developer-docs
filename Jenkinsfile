// Using declarative pipeline: https://jenkins.io/doc/book/pipeline/syntax/
pipeline {

  agent any
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

             # Run SSH tunnel if Swarm response fails
             ${SWARM_TEST} node ls
             if [ $? -ne 0 ]
              then
                autossh -f ${SSH_OPTS} docker@\$(${GET_TEST_MANAGER}) -NL localhost:2374:/var/run/docker.sock &
                ${SWARM_TEST} docker node ls || echo "Swarm does not work, either trouble with SSH or Swarm itself!"
              else
                echo "SSH Tunnel to Swarm works"
             fi

             ${SWARM_TEST} stack deploy --prune -c ci/deploy/develop-stack.yml ${STACK}
             # Test deployed services
             for service in $(${SWARM_TEST} stack services --format '{{ .Name }}' ${STACK})
              do ${SWARM_TEST} service update ${service}
             done
          '''
    }}
    stage('Deploy stack to Swarm production?') {
      when { branch 'master' }
        steps {
          sh 'echo "I will be big boy one day and i will deploy to production then"'
     }}}}
