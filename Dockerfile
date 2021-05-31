FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/my-test-app-0.0.1-SNAPSHOT.jar
ADD ${JAR_FILE} my-test-app.jar
ENTRYPOINT ["java","-jar","/my-test-app.jar"]
