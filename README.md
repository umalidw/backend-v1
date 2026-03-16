# Sample Game 01 Backend

A Spring Boot application with MySQL database, containerized with Docker.

## Prerequisites

- Docker and Docker Compose installed on your system

## Quick Start

### Option 1: Build and Run with Docker (Recommended)

```bash
# Build and start all services
docker-compose up --build

# Or run in detached mode
docker-compose up --build -d
```

### Option 2: Build Locally (if you have Java 17 and Maven installed)

```bash
# On Linux/Mac
./build.sh

# On Windows
build.bat
```

## Services

- **App**: Spring Boot application running on port 8080
- **MySQL**: Database running on port 3306

## Environment Variables

The application uses the following environment variables (configured in docker-compose.yml):

- `MYSQL_HOST`: mysql
- `MYSQL_PORT`: 3306
- `MYSQL_DB`: game_db
- `MYSQL_USER`: root
- `MYSQL_PASS`: 12345

## API Endpoints

Once running, the application will be available at:
- http://localhost:8080

## Stopping the Application

```bash
docker-compose down
```

## Troubleshooting

If you encounter build issues:
1. Make sure Docker is running
2. Try rebuilding: `docker-compose build --no-cache`
3. Check logs: `docker-compose logs app`
