# Multi-stage build για βελτιστοποίηση
# Stage 1: Build stage
FROM eclipse-temurin:17-jdk-jammy AS builder

# Εγκατάσταση Gradle
RUN apt-get update && \
    apt-get install -y wget unzip && \
    wget https://services.gradle.org/distributions/gradle-8.3-bin.zip -P /tmp && \
    unzip -d /opt/gradle /tmp/gradle-8.3-bin.zip && \
    rm /tmp/gradle-8.3-bin.zip && \
    apt-get clean

ENV GRADLE_HOME=/opt/gradle/gradle-8.3
ENV PATH=${GRADLE_HOME}/bin:${PATH}

# Ορισμός working directory
WORKDIR /app

# Αντιγραφή build files
COPY build.gradle settings.gradle ./
COPY src/ src/

# Build της εφαρμογής
RUN gradle clean bootJar --no-daemon

# Stage 2: Runtime stage
FROM eclipse-temurin:17-jre-jammy

# Δημιουργία non-root user για ασφάλεια
RUN groupadd -r spring && useradd -r -g spring spring

# Ορισμός working directory
WORKDIR /app

# Αντιγραφή του jar από το builder stage
COPY --from=builder /app/build/libs/*.jar app.jar

# Αλλαγή ownership στον spring user
RUN chown spring:spring app.jar

# Χρήση του spring user
USER spring

# Εκθέτουμε το port 8080
EXPOSE 8080

# Ορισμός JVM options για production
ENV JAVA_OPTS="-Xmx512m -Xms256m"

# Εκκίνηση της εφαρμογής
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]