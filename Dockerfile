FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Install netcat for wait-for-it script
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Copy Maven wrapper and pom.xml first for better caching
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

# Fix line endings + make executable + build
RUN sed -i 's/\r$//' mvnw && \
    chmod +x mvnw && \
    ./mvnw clean package -DskipTests

# Copy wait scripts
COPY wait-for-it.sh .
COPY wait-for-mysql.sh .

# Fix line endings for scripts too
RUN sed -i 's/\r$//' wait-for-it.sh && \
    sed -i 's/\r$//' wait-for-mysql.sh && \
    chmod +x wait-for-it.sh wait-for-mysql.sh

# The JAR will be in target/api.jar based on finalName in pom.xml
ENTRYPOINT ["./wait-for-mysql.sh", "mysql", "3306", "java", "-jar", "target/api.jar"]