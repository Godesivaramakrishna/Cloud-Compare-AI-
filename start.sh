#!/bin/bash
# CloudCompare AI - Quick Start Script
# This script sets up and runs the CloudCompare AI application locally

set -e  # Exit on error

echo "========================================="
echo "CloudCompare AI - Quick Start"
echo "========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check Java installation
echo -e "${BLUE}[1/6]${NC} Checking Java installation..."
if ! command -v java &> /dev/null; then
    echo -e "${RED}ERROR: Java is not installed${NC}"
    echo "Please install Java 25 or later from: https://www.oracle.com/java/technologies/downloads/"
    exit 1
fi
JAVA_VERSION=$(java -version 2>&1 | grep -oP 'version "\K[^"]*' || echo "unknown")
echo -e "${GREEN}✓ Java ${JAVA_VERSION} found${NC}"

# Check Git installation
echo ""
echo -e "${BLUE}[2/6]${NC} Checking Git installation..."
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}WARNING: Git is not installed${NC}"
    echo "Consider installing Git for version control: https://git-scm.com"
else
    GIT_VERSION=$(git --version | awk '{print $3}')
    echo -e "${GREEN}✓ Git ${GIT_VERSION} found${NC}"
fi

# Check if Docker is available (optional)
echo ""
echo -e "${BLUE}[3/6]${NC} Checking Docker (optional)..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version | awk '{print $3}' | sed 's/,//')
    echo -e "${GREEN}✓ Docker ${DOCKER_VERSION} found${NC}"
    echo "  You can use: docker-compose up -d"
else
    echo -e "${YELLOW}ℹ Docker not found (optional)${NC}"
    echo "  Install Docker to use containerized deployment: https://www.docker.com"
fi

# Create .env file if it doesn't exist
echo ""
echo -e "${BLUE}[4/6]${NC} Setting up environment..."
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file from .env.example${NC}"
    if [ -f .env.example ]; then
        cp .env.example .env
        echo -e "${YELLOW}Please edit .env with your settings:${NC}"
        echo "  - GROQ_API_KEY: Your Groq API key"
        echo "  - JWT_SECRET: A secure secret for JWT"
        echo ""
        read -p "Press Enter to continue after updating .env file..."
    fi
fi

# Build the project
echo ""
echo -e "${BLUE}[5/6]${NC} Building CloudCompare AI..."
if [ -f "mvnw" ]; then
    chmod +x mvnw
    ./mvnw clean install -DskipTests
else
    mvn clean install -DskipTests
fi

if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed!${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Build successful${NC}"

# Start the application
echo ""
echo -e "${BLUE}[6/6]${NC} Starting application..."
echo -e "${GREEN}Application will start on http://localhost:5000${NC}"
echo ""
echo "Access points:"
echo "  - Main application: http://localhost:5000"
echo "  - Login page: http://localhost:5000/login.html"
echo "  - Sign up page: http://localhost:5000/signup.html"
echo "  - H2 Console: http://localhost:5000/h2-console"
echo ""
echo "To stop the application, press Ctrl+C"
echo ""
echo "========================================="

# Run the application
if [ -f "mvnw" ]; then
    ./mvnw spring-boot:run
else
    mvn spring-boot:run
fi
