@echo off
REM Complete GitHub Push Script - With Credentials Helper
REM This script sets up git credential caching and completes the push

echo.
echo ==========================================
echo CloudCompare AI - Complete GitHub Push
echo ==========================================
echo.

cd /d "c:\Users\goder\OneDrive\Desktop - Copy\CloudCampare-Ai-main"

REM Check git status
echo [1/3] Checking Git Repository Status...
git status
echo.

REM Set up credential caching to store credentials temporarily
echo [2/3] Setting up credential caching...
git config --global credential.helper wincred
echo Credential helper configured

echo.
echo [3/3] Pushing to GitHub...
echo.
echo When prompted for credentials:
echo   - Username: Your GitHub username (e.g., Godesivaramakrishna)
echo   - Password: Your GitHub Personal Access Token (NOT your password)
echo.
echo Get token from: https://github.com/settings/tokens
echo.
echo Pushing...
git push -u origin main

if errorlevel 1 (
    echo.
    echo ==========================================
    echo ERROR: Push failed
    echo ==========================================
    echo.
    echo Troubleshooting:
    echo 1. Verify you have a GitHub Personal Access Token
    echo 2. Repository must exist at: https://github.com/Godesivaramakrishna/Cloud-Compare-AI
    echo 3. Token must have 'repo' scope
    echo.
    pause
    exit /b 1
) else (
    echo.
    echo ==========================================
    echo SUCCESS! Project pushed to GitHub
    echo ==========================================
    echo.
    echo Repository: https://github.com/Godesivaramakrishna/Cloud-Compare-AI
    echo.
    echo View your project on GitHub now!
    echo.
    pause
    exit /b 0
)
