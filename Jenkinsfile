try{
    node{
        def mavenHome
        def mavenCMD
        def docker
        def dockerCMD
        def tagName = "2.0"
        
        stage('Preparation'){
            echo "Preparing the Jenkins environment with required tools..."
            mavenHome = tool name: 'maven', type: 'maven'
            mavenCMD = "${mavenHome}/bin/mvn"
            docker = tool name: 'docker', type: 'org.jenkinsci.plugins.docker.commons.tools.DockerTool'
            dockerCMD = "docker"
        }
        
        stage('git checkout'){
            echo "Checking out the code from git repository..."
            git 'https://github.com/Rakeshiimt06/batch10.git'
        }
        
        stage('Build, Test and Package'){
            echo "Building the addressbook application..."
            sh "${mavenCMD} clean package"
        }
        
        stage('Sonar Scan'){
            echo "Scanning application for vulnerabilities..."
            sh "${mavenCMD} sonar:sonar -Dsonar.projectKey=Rakesh-project -Dsonar.host.url=http://35.238.162.115:9000 -Dsonar.login=08f91ab9bffe21b195de8b027eba3cfe77b54ac0"
        }
        
        stage('Integration test'){
            echo "Executing Regression Test Suits..."
            // command to execute selenium test suits
        }
        
        stage('publish report'){
            echo " Publishing HTML report.."
            junit 'target/surefire-reports/TEST-SampleTest.xml'
           
        }
        
        stage('Build Docker Image'){
            echo "Building docker image for addressbook application ..."
            sh "${dockerCMD} build -t rakeshiimt06/my-test-app:${tagName} ."
        }
        
        stage("Push Docker Image to Docker Registry"){
            echo "Pushing image to docker hub"
            withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'dockerHubPwd', usernameVariable: 'dockerHubUsr')]) {
            sh "${dockerCMD} login -u $dockerHubUsr -p $dockerHubPwd"
            sh "${dockerCMD} push rakeshiimt06/my-test-app:${tagName}"
            }
        }
        
        stage('Deploy Application'){
            echo "Installing desired software.."
            echo "Bring docker service up and running"
            echo "Deploying addressbook application"
        }
        
        stage('Clean up'){
            echo "Cleaning up the workspace..."
            cleanWs()
        }
    }
}
catch(Exception err){
    echo "Exception occured..."
    currentBuild.result="FAILURE"
    emailext body: 'Your build has been successful or unsuccessful', subject: 'Build failed', to: 'rakeshiimt06@gmail.com'
}
finally {
    (currentBuild.result!= "ABORTED") && node("master") {
        echo "finally gets executed and end an email notification for every build"
        emailext body: 'Your build has been successful or unsuccessful', subject: 'Build Result', to: 'rakeshiimt06@gmail.com'
    }
    
}
