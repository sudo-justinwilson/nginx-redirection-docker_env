node('normalSlave')
{
    stage('build')
    {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'my-jenkins', url: 'git@github.com:sudo-justinwilson/nginx-redirection-docker_env.git']]])
        
        echo 'finished git '
        
        tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
        sh 'docker -v'
        sh 'docker images'
        
        echo 'start test docker pipeline:'
        
        withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-319', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY']]) 
        {
            
            docker.withRegistry('325438770462.dkr.ecr.ap-southeast-2.amazonaws.com/nginx-jenkins-test')
            {
               // see which dir we're in:
         sh 'pwd && ls -lA'
         // build the docker image:
         sh 'docker build -t "nginx-redirection" . '
         // tag image:
         sh 'docker tag nginx-redirection 325438770462.dkr.ecr.ap-southeast-2.amazonaws.com/nginx-jenkins-test'
         // login to ECR:
         def login = ecrLogin(email:false)
         sh login
         // check image was built:
         sh 'docker images'
         // push image to ECR:
         sh 'docker push 325438770462.dkr.ecr.ap-southeast-2.amazonaws.com/nginx-jenkins-test'
            }
        }
    }
}
