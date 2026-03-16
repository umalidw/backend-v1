FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Install netcat for wait-for-it script
RUN apt-get update && apt-get install -y netcat-openbsd && rm -rf /var/lib/apt/lists/*

# Copy Maven wrapper and pom.xml first for better caching
COPY mvnw .
COPY mvnw.cmd .
COPY .mvn .mvn
COPY pom.xml .

# Copy source code
COPY src ./src

# Make mvnw executable and build the application
RUN chmod +x mvnw && \
    ./mvnw clean package -DskipTests

# Copy wait scripts
COPY wait-for-it.sh .
COPY wait-for-mysql.sh .
RUN chmod +x wait-for-it.sh wait-for-mysql.sh

# The JAR will be in target/api.jar based on finalName in pom.xml
ENTRYPOINT ["./wait-for-mysql.sh", "mysql", "3306", "java", "-jar", "target/api.jar"]