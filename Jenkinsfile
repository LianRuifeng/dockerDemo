
	
	node{
        stage('Prepare') {
            echo "1.Prepare Stage"
            checkout scm
            pom = readMavenPom file: 'pom.xml'
            docker_host = "lrf"
            img_name = "${docker_host}/${pom.artifactId}"
            docker_img_name = "${docker_host}/${img_name}"
			//镜像的版本号
			tag = "latest"
			//Harbor的url地址
			nexus_url = "http://192.168.137.159:8081/repository/docker-hosted-repository/"
            echo "group: ${pom.groupId}, artifactId: ${pom.artifactId}, version: ${pom.version}"
            echo "docker-img-name: ${docker_img_name}"
            //script {
            //    build_tag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
            //    if (env.BRANCH_NAME != 'master' && env.BRANCH_NAME != null) {
            //        build_tag = "${env.BRANCH_NAME}-${build_tag}"
            //    }
            //}
        }
        //stage('Test') {
        //    echo "2.Test Stage"
        //   sh "mvn test"
        //}
        stage('Build') {
            echo "3.Build Docker Image Stage"
            //sh "mvn package  -Dmaven.test.skip=true"
            //sh "docker login --username='lrf1990' --password='ab123456789'"
            sh "mvn clean package dockerfile:build -Dmaven.test.skip=true"
        }
        stage('Push') {
            echo "4.Deploy jar and Push Docker Image Stage"
            //sh "mvn deploy -Dmaven.test.skip=true"
            //sh "docker login --username='admin' --password='admin'"
            //echo "${env.BUILD_ID} ${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
            sh "docker tag ${img_name} ${img_name}:latest"
            //sh "docker tag ${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
            //sh "docker push lrf/dockerdemo:latest"
            //sh "docker run -it -d -p 8888:8004 --name ${docker_img_name}" 

					withCredentials([usernamePassword(credentialsId: 'nexusCard', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUser')]) {
						sh "docker login -u ${dockerUser} -p ${dockerPassword} ${nexus_url}"
						sh "docker push ${img_name}:latest"
						//sh "docker push ${docker_img_name}:${pom.version}"
						//sh "docker push ${docker_img_name}:${build_tag}"
					}

	
        }


    }

