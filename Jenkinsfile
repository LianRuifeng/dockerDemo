
	
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
			nexus_url = "http://192.168.3.11:5000"
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
        /*stage('Build') {
            echo "3.Build Docker Image Stage"
            //sh "mvn package  -Dmaven.test.skip=true"
            //sh "docker login --username='lrf1990' --password='ab123456789'"
            sh "mvn clean package dockerfile:build -Dmaven.test.skip=true"
        }*/
        stage('Build and Push') {
            echo "3.build push and deploy jar and Push Docker Image Stage"
            //sh "mvn deploy -Dmaven.test.skip=true"
            //sh "docker login --username='admin' --password='admin'"
            //echo "${env.BUILD_ID} ${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
           
            //sh "docker tag ${docker_img_name}:${build_tag} ${docker_img_name}:${pom.version}"
            //sh "docker push lrf/dockerdemo:latest"
            //sh "docker run -it -d -p 8888:8004 --name ${docker_img_name}" 

					withCredentials([usernamePassword(credentialsId: 'admin', passwordVariable: 'dockerPassword', usernameVariable: 'dockerUser')]) {
						echo "dockername ${dockerUser}"
						echo "dockerps ${dockerPassword}"
						echo "nexusurl ${nexus_url}"
						sh "docker login -u ${dockerUser} -p ${dockerPassword} ${nexus_url}"
						sh "mvn clean package dockerfile:build ${nexus_url}/${img_name}:latest -Dmaven.test.skip=true"
						sh "docker tag ${img_name} ${nexus_url}/${img_name}:latest"
						sh "docker push ${nexus_url}/${img_name}:latest"
						//sh "docker push ${docker_img_name}:${pom.version}"
						//sh "docker push ${docker_img_name}:${build_tag}"
					}

	
        }


    }

