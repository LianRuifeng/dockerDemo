    node{
        stage('Prepare') {
            echo "1.Prepare Stage"
            checkout scm
            pom = readMavenPom file: 'pom.xml'
            docker_host = "docker.ryan-miao.com"
            img_name = "${pom.groupId}-${pom.artifactId}"
            docker_img_name = "${docker_host}/${img_name}"
            echo "group: ${pom.groupId}, artifactId: ${pom.artifactId}, version: ${pom.version}"
            echo "docker-img-name: ${docker_img_name}"
            script {
                build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
                if (env.BRANCH_NAME != 'master' && env.BRANCH_NAME != null) {
                    build_tag = "${env.BRANCH_NAME}-${build_tag}"
                }
            }
        }
        //stage('Test') {
        //    echo "2.Test Stage"
        //   sh "mvn test"
        //}
        stage('Build') {
            echo "3.Build Docker Image Stage"
            //sh "mvn package  -Dmaven.test.skip=true"
            sh "mvn clean package docker:build -Dmaven.test.skip=true"
        }
        stage('Push') {
            echo "4.Deploy jar and Push Docker Image Stage"
            //sh "mvn deploy -Dmaven.test.skip=true"
            //sh "docker tag ${docker_img_name}:${build_tag} ${docker_img_name}:latest"
            echo "${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
            sh "docker tag ${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
            sh "docker run -it -d -p 8888:8004 --name dockerdemo" 
            //withCredentials([usernamePassword(credentialsId: 'docker-register', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUser')]) {
            //    sh "docker login -u ${dockerUser} -p ${dockerPassword} docker.ryan-miao.com"
            //    sh "docker push ${docker_img_name}:latest"
            //    sh "docker push ${docker_img_name}:${pom.version}"
            //    sh "docker push ${docker_img_name}:${build_tag}"
           // }*/
        }
        //stash 'complete-build'
    }
    if (env.BRANCH_NAME == 'master' || env.BRANCH_NAME == null) {
        timeout(time: 10, unit: 'MINUTES') {
            input '确认要部署线上环境吗？'
        }
    }
   /* node('slave001'){
   //     stage('Deploy') {
   //         //unstash 'complete-build'
   ///         echo "5. Deploy Stage"
    //        sh "sed -i 's/<IMG_NAME>/${img_name}:${build_tag}/' location/k8s.yaml"
   //         sh "sed -i 's/<BRANCH_NAME>/${env.BRANCH_NAME}/' location/k8s.yaml"
   //         sh "/data/opt/kubernetes/client/bin/kubectl apply -f ${WORKSPACE}/location/k8s.yaml --record"
   //     }
    //}*/
