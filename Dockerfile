## FROM openjdk:8-jdk-alpine
##For Java 11 Use This
#FROM adoptopenjdk/openjdk11:alpine-jre
#ARG JAR_FILE=target/*.jar
#COPY ${JAR_FILE} app.jar
#ENTRYPOINT ["java","-jar","/app.jar"]

FROM adoptopenjdk/openjdk11:alpine-jre
ADD build/libs/dockerkubernetesapp-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS=""
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]