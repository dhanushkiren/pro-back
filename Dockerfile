# Build stage
FROM maven:3.9.5-eclipse-temurin-17 AS build
COPY src /home/app/src
COPY pom.xml /home/app
WORKDIR /home/app
RUN mvn clean package


# Package stage
FROM openjdk:17-jdk-slim
COPY --from=build /home/app/target/ProductDetails-0.0.1-SNAPSHOT.jar /usr/local/lib/demo.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/demo.jar"]