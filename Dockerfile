FROM docker.io/library/maven:3.8.1-openjdk-8
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package

FROM tomcat:9.0.53-jdk8
RUN mkdir -p /usr/local/tomcat/webapps
RUN chmod -R 777 /usr/local/tomcat/conf
COPY --from=build /app/target/helloworld-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/helloworld.war
