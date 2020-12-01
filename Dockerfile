FROM java:8
VOLUME /tmp
ADD target/docker_demo-0.0.1-SNAPSHOT.jar /app.jar
ENV TZ Asia/Shanghai
RUN bash -c 'touch /app.jar'
EXPOSE 8888
ENTRYPOINT ["java","-Xmx400m","-Xms200m","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]