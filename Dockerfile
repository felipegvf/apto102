# First compile app
FROM maven:3.9.9-amazoncorretto-21-alpine AS build
WORKDIR /app
COPY pom.xml ./
COPY src ./src
RUN mvn clean package -DskipTests

# Second create image
FROM amazoncorretto:21-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]