# Use the official OpenJDK base image with the desired Java version
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot JAR file into the container
# Make sure to build your application JAR with `mvn clean package` before doing this
COPY target/springbootcrudrest-0.0.1-SNAPSHOT.jar app.jar

# Expose the port that the Spring Boot app will run on (default is 8080, but you want 9090)
EXPOSE 9090

# Run the application using Java
ENTRYPOINT ["java", "-jar", "app.jar"]

