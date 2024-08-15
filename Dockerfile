# Use the official Gradle image with JDK 21
FROM gradle:8.10.0-jdk17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the Gradle wrapper and settings files
COPY gradlew ./
COPY gradlew.bat ./
COPY settings.gradle.kts ./
COPY gradle/ ./gradle/

# Copy the source code and build.gradle.kts
COPY app/ ./app/

# Build the application
RUN ./gradlew build

# Use the official OpenJDK image for the runtime
FROM eclipse-temurin:17-jre

# Set the working directory in the container
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app/app/build/libs/*.jar ./app.jar

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "app.jar"]
