pipeline {
    agent
    {
      label "anna"
    }

    stages {
        stage('Git') {
            steps {
                // Крок для забору коду з репозиторію (git checkout та інше)
                git branch: 'main', url: 'https://github.com/AnichkaKb/gitea.git'
            }
         }

         stage('Clean Container') {
             steps {
                script {
                     
                    sh 'docker container prune'
                    //sh 'docker stop $(docker ps -q)'

                    
                }
            }
         }
        
        stage('Build Docker Container') {
            steps {
                script {
                     
                    sh 'docker build -t giteaapp .'
                    
                }
            }
        } 
    
        stage('Run Docker-compose') {
            steps {
                script {
                    
                    sh 'docker-compose up -d'
                }
            }
        } 
        stage('Deploy Docker') {
            steps {
                script {
                    sh 'scp docker-compose.yml jenkins@192.168.56.103:/home/jenkins/'
                    sh 'scp  -r custom/conf jenkins@192.168.56.103:/home/jenkins/'
                    sh 'ssh jenkins@192.168.56.103 "docker-compose up"'
                }
            }
        }         
    }
}
