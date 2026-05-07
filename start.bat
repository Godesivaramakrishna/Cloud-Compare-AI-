@echo off
REM CloudCompare AI - Quick Start Script (Windows)
REM This script sets up and runs the CloudCompare AI application locally

cls
echo =========================================
echo CloudCompare AI - Quick Start
echo =========================================
echo.

REM Check Java installation
echo [1/5] Checking Java installation...
java -version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Java is not installed
    echo Please install Java 25 or later from: https://www.oracle.com/java/technologies/downloads/
    pause
    exit /b 1
)
for /f "tokens=3" %%i in ('java -version 2^>^&1 ^| find "version"') do set JAVA_VERSION=%%i
echo [OK] Java %JAVA_VERSION% found
echo.

REM Check Git installation
echo [2/5] Checking Git installation...
git --version >nul 2>&1
if errorlevel 1 (
    echo [WARNING] Git is not installed
    echo Consider installing Git for version control: https://git-scm.com
) else (
    for /f "tokens=3" %%i in ('git --version') do set GIT_VERSION=%%i
    echo [OK] Git %GIT_VERSION% found
)
echo.

REM Check Docker (optional)
echo [3/5] Checking Docker (optional)...
docker --version >nul 2>&1
if errorlevel 1 (
    echo [INFO] Docker not found (optional)
    echo Install Docker to use containerized deployment: https://www.docker.com
) else (
    for /f %%i in ('docker --version') do set DOCKER_VERSION=%%i
    echo [OK] %DOCKER_VERSION% found
    echo You can use: docker-compose up -d
)
echo.

REM Create .env file
echo [4/5] Setting up environment...
if not exist .env (
    echo Creating .env file from .env.example...
    if exist .env.example (
        copy .env.example .env >nul
        echo [INFO] Please edit .env with your settings:
        echo   - GROQ_API_KEY: Your Groq API key
        echo   - JWT_SECRET: A secure secret for JWT
        echo.
        pause
    )
)
echo.

REM Build
echo [5/5] Building CloudCompare AI...
if exist mvnw.cmd (
    call mvnw.cmd clean install -DskipTests
) else (
    mvn clean install -DskipTests
)

if errorlevel 1 (
    echo Build failed!
    pause
    exit /b 1
)
echo [OK] Build successful
echo.

echo =========================================
echo Starting application...
echo =========================================
echo.
echo Application will start on http://localhost:5000
echo.
echo Access points:
echo   - Main application: http://localhost:5000
echo   - Login page: http://localhost:5000/login.html
echo   - Sign up page: http://localhost:5000/signup.html
echo   - H2 Console: http://localhost:5000/h2-console
echo.
echo To stop the application, press Ctrl+C
echo.

if exist mvnw.cmd (
    call mvnw.cmd spring-boot:run
) else (
    mvn spring-boot:run
)
