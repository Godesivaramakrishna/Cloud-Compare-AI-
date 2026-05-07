FROM openjdk:25-jdk-slim

# Metadata
LABEL maintainer="Cloud Compare AI <noreply@cloudcompare.ai>"
LABEL version="1.0.0"
LABEL description="AI-powered cloud service comparison tool"

# Install curl for health checks
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Create non-root user for security
RUN useradd -m -u 1000 appuser

# Set working directory
WORKDIR /app

# Copy Maven wrapper and pom.xml
COPY mvnw* ./
COPY .mvn .mvn
COPY pom.xml ./

# Build dependencies
RUN chmod +x ./mvnw && ./mvnw dependency:resolve

# Copy source code
COPY src ./src

# Build application
RUN ./mvnw clean package -DskipTests

# Copy JAR to runtime location
RUN mv target/cloud-compare-ai-*.jar app.jar && \
    rm -rf target .mvn mvnw* pom.xml src

# Change ownership to appuser
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 5000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD curl -f http://localhost:5000/actuator/health || exit 1

# Environment variables
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Xmx512m -Xms256m"
ENV SPRING_PROFILES_ACTIVE=prod

# Run application
CMD ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
